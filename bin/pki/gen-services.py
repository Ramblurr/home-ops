#!/usr/bin/env python3
import os
import pathlib
import yaml
import subprocess
from os import path
from datetime import datetime
from OpenSSL import crypto as c
import sys
import json

f = open("pki/pki-hosts.yml", "r")
config = yaml.safe_load(f)

certs_dir = path.abspath(config["dir"])
print(f"Using certs dir f{certs_dir}")

pathlib.Path(certs_dir).mkdir(parents=True, exist_ok=True)


def get_not_after(pem_path):
    cert = c.load_certificate(c.FILETYPE_PEM, open(pem_path, "rt").read())
    return datetime.strptime(cert.get_notAfter().decode("utf-8"), "%Y%m%d%H%M%SZ")


def cert_expired(pem_path):
    not_after = get_not_after(pem_path)
    return datetime.utcnow() > not_after


def cert_exists(pem_path):
    return path.exists(pem_path)


def status():
    ca_file = path.join(certs_dir, "root-ca.pem")
    if not cert_exists(ca_file):
        print("root-ca.pem doesn't exist")
        sys.exit(1)
    print("[OK] root-ca.pem")
    for cert in config["hosts"]:
        host = cert["cn"]
        pem_path = path.join(certs_dir, f"{host}.pem")
        exists = cert_exists(pem_path)
        if not exists:
            print(f"![NE] {host}")
            continue
        expired = cert_expired(pem_path)
        if expired:
            print(f"![EX] {host} exists={exists} expired={expired}")
            continue

        print(f"[OK] {host}")


def gen(cert):
    print(cert)
    host = cert["cn"]
    extras = cert.get("extras", [])
    names = [host] + extras
    csr_file = path.join(certs_dir, f"{host}-csr.json")
    # "algo": "rsa",
    # "size": 4096
    csr_content = """{
  "key": {
    "algo": "ecdsa",
    "size": 256
  },
  "names": [
    {
      "O": "socozy",
      "OU": "SoCozy Security",
      "L": "San Francisco",
      "ST": "California",
      "C": "USA"
    }
  ],
  "CN": "s1",
  "hosts": %s
}""" % (
        json.dumps(names)
    )

    with open(csr_file, "w") as f:
        f.write(csr_content)

    ca_file = path.join(certs_dir, "root-ca.pem")
    ca_key_file = path.join(certs_dir, "root-ca-key.pem")
    gencert_file = path.join(certs_dir, "gencert.json")
    # print(gencert_file)
    bare = path.join(certs_dir, host)
    args = f"cfssl gencert --ca {ca_file}  --ca-key {ca_key_file} --config {gencert_file} {csr_file} | cfssljson --bare {bare} bare"
    print(args)
    p = subprocess.Popen(args, shell=True, stdout=subprocess.PIPE)

    response = p.communicate()
    # print(response )
    print(f"![UP] {host}")


def update():
    ca_file = path.join(certs_dir, "root-ca.pem")
    if not cert_exists(ca_file):
        print("root-ca.pem doesn't exist")
        sys.exit(1)
    print("[OK] root-ca.pem")
    for entry in config["hosts"]:
        host = entry["cn"]
        pem_path = path.join(certs_dir, f"{host}.pem")
        exists = cert_exists(pem_path)
        if not exists or cert_expired(pem_path):
            gen(entry)
        else:
            print(f"[OK] {host}")


update()
# status()

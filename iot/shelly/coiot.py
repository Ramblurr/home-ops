import requests
import csv
import sys
import os

ha_ip = "10.9.4.25"
ssid = "SoCozy-not"
key = "vanity.riptide.province.eastward"
netmask = "255.255.254.0"
gateway = "10.8.60.1"
dns = "10.9.4.4"


def load_from_cli():
    if len(sys.argv) == 4:
        url = "http://" + sys.argv[1]
        new_ip = sys.argv[2]
        name = sys.argv[3]
        return url, new_ip, name
    else:
        print("usage: %s <current ip address> <new ip address> <name>" % (sys.argv[0]))
        sys.exit(1)


def load_from_csv():
    with open("shellys.csv", "r") as f:
        reader = csv.DictReader(f)
        for row in reader:
            yield row


def fetch(url, path):
    resp = requests.get(url + path)
    return resp.json()


def reboot(url):
    resp = requests.get(url + "/reboot")
    if resp.status_code != 200:
        print(resp.url)
        print("Shelly: Response status was {}".format(resp.status_code))
        raise Exception()
    return resp.json()


def send(url, path, data):
    resp = requests.post(url + path, data)
    if resp.status_code != 200:
        print(resp.url)
        print("Shelly: Response status was {}".format(resp.status_code))
        raise Exception()
    return resp.json()


def set_settings(url, name, new_ip):

    info = fetch(url, "/shelly")

    model = info["type"]
    mac = info["mac"]
    did = mac[len(mac) - 6 :]

    settings = fetch(url, "/settings")

    hostname = settings["device"]["hostname"]
    shelly_type = hostname.split("-")[0]

    print(f"model: {model}")
    print(f"mac: {mac}")
    print(f"did: {did}")
    print(f"type: {shelly_type}")

    full_name = f"{shelly_type}-{name}-{mac}"
    resp = send(
        url,
        "/settings",
        {
            "coiot_enable": True,
            "coiot_peer": f"{ha_ip}:5683",
            "name": full_name,
            "timezone": "Europe/Vienna",
        },
    )
    print(resp)

    resp = send(url, "/settings/cloud", {"enabled": "false"})
    print(resp)
    resp = send(
        url,
        "/settings/sta",
        {
            "enabled": True,
            "ssid": ssid,
            "key": key,
            "ipv4_method": "static",
            "ip": new_ip,
            "netmask": netmask,
            "gateway": gateway,
            "dns": dns,
        },
    )
    print(resp)
    return shelly_type, model, name, mac


def add_to_db(name, shelly_type, model, full_name, new_ip, mac):
    headers = ["Name", "Type", "Model", "Hostname", "IP", "MAC"]
    file_exists = os.path.isfile("shellys.csv")
    if not file_exists:
        with open("shellys.csv", "w+") as f:
            writer = csv.DictWriter(f, fieldnames=headers)
            writer.writeheader()
    with open("shellys.csv", "a+") as f:
        writer = csv.writer(f)
        writer.writerow([name, shelly_type, model, full_name, new_ip, mac])


def import_from_cli():

    url, new_ip, name = load_from_cli()

    shelly_type, model, full_name, mac = set_settings(url, name, new_ip)
    add_to_db(name, shelly_type, model, full_name, new_ip, mac)


def update_from_csv():
    for row in load_from_csv():
        ip = row["IP"]
        name = row["Name"]
        _type = row["Type"]
        if _type is None or _type == "":
            print(f"skipping {name}")
            continue
        if ip == "10.8.60.15":
            continue
        url = f"http://{ip}"
        set_settings(url, name, ip)
        print("rebooting")
        reboot(url)


import_from_cli()

import requests
import csv
import sys
import os

url = ""
prefix = "10.8.60."
start = 10
end = 27


def fetch(path):
    resp = requests.get(url + path)
    return resp.json()


def send(path, data):
    resp = requests.post(url + path, data)
    if resp.status_code != 200:
        print(resp.url)
        print("Shelly: Response status was {}".format(resp.status_code))
        raise Exception()
    return resp.json()


current = start
while current <= end:
    try:
        ip = f"{prefix}{current}"
        url = f"http://{ip}"
        info = fetch("/reboot")
        print(f"rebooted {ip}")
    except KeyboardInterrupt:
        print("Aborted")
        sys.exit(1)
    except:
        print(f"failed to reboot {ip}")
    current += 1

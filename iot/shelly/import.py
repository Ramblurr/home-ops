import requests
import sys

if len(sys.argv) == 2:
    url = sys.argv[1]
else:
    url = "http://192.168.33.1"

# url = "http://10.8.50.55"
ssid = "SoCozy-not"
key = os.environ["WLAN_NOT_PASS"]


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


info = fetch("/shelly")

stype = info["type"]
mac = info["mac"]
did = mac[len(mac) - 6 :]

# print(f"type: {stype}")
# print(f"mac: {mac}")
# print(f"did: {did}")


resp = send("/settings/cloud", {"enabled": "false"})
# cloud = resp["enabled"]
# print(f"cloud: {cloud}")
# print("wifi: {ssid}")

print(f"{stype}\t{mac}\t{did}")

resp = send(
    "/settings/sta",
    {
        "enabled": True,
        "ssid": ssid,
        "key": key,
        "ipv4_method": "dhcp",
        "ip": None,
        "gw": None,
        "mask": None,
        "dns": None,
    },
)

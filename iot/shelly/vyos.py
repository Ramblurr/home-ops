import csv

devices = []
with open("shellys.csv", "r") as f:
    r = csv.DictReader(f)
    for row in r:
        devices.append(row)

problems = []
ok = []
for device in devices:
    if (
        device["IP"] == ""
        or not device["MAC"]
        or device["MAC"] == ""
        or device["Name"] == ""
    ):
        problems.append(device)
    else:
        ok.append(device)

ok = sorted(ok, key=lambda x: x["IP"])
for device in ok:
    # print(device)
    if ":" not in device["MAC"]:
        device["MAC"] = ":".join(
            [device["MAC"][i : i + 2] for i in range(0, len(device["MAC"]), 2)]
        )
    if "shelly" in device["Type"]:
        device["Name"] = f"shelly-{device['Name']}"
    print(
        """set service dhcp-server shared-network-name NOT subnet 10.8.60.0/23 static-mapping {Name} ip-address '{IP}'
set service dhcp-server shared-network-name NOT subnet 10.8.60.0/23 static-mapping {Name} mac-address '{MAC}'""".format(
            **device
        )
    )

for device in ok:
    if "shelly" in device["Name"]:
        print(
            """set firewall group address-group shellys address '{IP}'""".format(
                **device
            )
        )
    elif "wled" in device["Name"]:
        print(
            """set firewall group address-group wled address '{IP}'""".format(**device)
        )
    else:
        print(
            """set firewall group address-group esphome address '{IP}'""".format(
                **device
            )
        )

if problems:
    print()
    for p in problems:
        print(p["Name"])
        print(p["IP"])
        print(p["MAC"])
        print()

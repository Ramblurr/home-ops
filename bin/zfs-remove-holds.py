# This script will remove zrepl holds on snapshots
# so that they can be deleted
#
# How to use:
#  Edit "dataset" with the dataset to list snapshots from
#  edit check_str as a safety, only snapshot names containing this string
#  will be processed
#
# You should run this on your truenas/zfs box directly
import subprocess
def run(cmd):
        #print(f"exec: {cmd}")
        return subprocess.check_output(cmd, shell=True).decode("utf-8")



dataset =  "tank/replication/mali"
check_str =  "mali"

r = run(f"zfs list -H -o name -t snapshot -r {dataset}").splitlines()
for snap in r[1:]:
        if check_str not in snap:
                print(f"{snap} does not contain {check_str}")
                continue
        print(f"processing snap {snap}")
        if "@" not in snap:
                print(f"NOT A SNAPSHOT!! {snap}")
                break
        for hold in run(f"zfs holds {snap}").splitlines()[1:]:
                line = hold.split("  ")
                name = line[0]
                tag = line[1]
                assert name.strip() != ""
                assert tag.strip() != ""
                if check_str not in name:
                        print(f"{name} does not contain {check_str}")
                        continue
                if "zrepl" not in tag:
                        print(f"{name} has non zrepl tag {tag}")
                        continue
                run(f"zfs release -r {tag} {name}")

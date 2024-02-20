import os
import sys
import json
import shutil
import subprocess

# This script is used to migrate from a single bucket containing a bunch of volsynced restic repos for different apps
# to a per-app bucket. At the same time it moves the restic repo into the /restic subdir
#
# Example:
# rclone copy minio-root:/mono-bucket/plex/ -> minio-root:/volsync-plex/restic/
# rclone copy minio-root:/mono-bucket/sonarr/ -> minio-root:/volsync-sonarr/restic/


src_remote = "minio-root"
dest_remote = "minio-root"
src_mono_bucket = "/k8s-prod-volsync"

# mapping from subdir name in the mono-bucket to the name of the per-app bucket
to_migrate = {
    "autoscan": "volsync-autoscan",
    "calibre": "volsync-calibre",
    "calibre-web": "volsync-calibre-web",
    "invoiceninja-mariadb-0": "volsync-invoiceninja-mariadb",
    "invoiceninja-public": "volsync-invoiceninja-public",
    "jellyfin": "volsync-jellyfin",
    # "lidarr": "lidarr",
    "lidarr-config-v1": "volsync-lidarr",
    "matrix-synapse": "volsync-matrix-synapse-ol",
    # "nextcloud-home": "volsync-nextcloud-home",
    # "nextcloud-ol": "",
    # "nextcloud-sc": "",
    "overseerr": "volsync-overseerr",
    "plex": "volsync-plex",
    "prowlarr": "volsync-prowlarr",
    # "qbittorrent": "volsync-qbittorrent",
    "qbittorrent2": "volsync-qbittorrent",
    "radarr": "volsync-radarr",
    "readarr": "volsync-readarr",
    "readarr-audiobooks": "volsync-readarr-audiobooks",
    "recyclarr": "volsync-recyclarr",
    "sabnzbd": "volsync-sabnzbd",
    "sonarr": "volsync-sonarr",
    "tautulli": "volsync-tautulli",
}


def parse_transfer_stats(log):
    xBytes = log["stats"]["bytes"]
    tBytes = log["stats"]["totalBytes"]
    if tBytes > 0:
        percent = (xBytes / tBytes) * 100
    else:
        percent = 0
    # convert to megabytes if more than 1 megabyte
    if xBytes > 1024000:
        return "MiB", xBytes / 1024000, tBytes / 1024000, percent
    return "Bytes", xBytes, tBytes, percent


def report_progress(log_line):
    log = json.loads(log_line)
    # print(log_line)
    if "stats" in log:
        unit, xferred, total, percent = parse_transfer_stats(log)
        print(
            f"\t{src}->{dest} {xferred:.2f} {unit} / {total:.2f} {unit} {percent:.2f}%"
        )
    else:
        msg = log.get("msg")
        if (
            "Copied (server-side copy)" not in msg
            and "Updated modification time in destination" not in msg
        ):
            print(f"\t{msg}")


def copy(src, dest):
    cmd = [
        "rclone",
        "copy",
        "-v",
        "--use-json-log",
        "--stats=1s",
        f"{src_remote}:/{src_mono_bucket}/{src}/",
        f"{dest_remote}:/{dest}/restic/",
    ]
    print(f"Copying {src} to {dest}")
    with subprocess.Popen(
        cmd,
        stderr=subprocess.PIPE,
        text=True,
        bufsize=1,
        universal_newlines=True,
    ) as proc:
        for log_line in proc.stderr:
            report_progress(log_line)


def main():
    for src, dest in to_migrate.items():
        copy(src, dest)


if __name__ == "__main__":
    main()

# how to

1. download "Raspberry Pi OS Lite" from https://www.raspberrypi.com/software/operating-systems/
2. uncompress with `xz -d `
2. use `go run main.go ./2022---` to get mount points
3. mount first mount point (this is /boot)
4. add:
   * userconf (see password manager for contents) - this creates the default user
     *  `vim /mnt/userconf`
   * `touch /mnt/ssh`
   * `cp firstboot.sh /mnt/firstboot.sh`
5. umount, then mount the second mount point (this is /)
   * add `/mnt/lib/systemd/system/firstboot.service` (see file)
   * `cd /mnt/etc/systemd/system/multi-user.target.wants && ln -s /lib/systemd/system/firstboot.service .`
   * edit `/mnt/etc/ssh/sshd_config` as per below
      PasswordAuthentication no
      PermitRootLogin no
   * add /home/admin ssh config

# orig
---
Prepare a headless secured rpi image that has secure ssh on boot

sources:

https://github.com/nmcclain/raspberian-firstboot
https://github.com/kenfallon/fix-ssh-on-pi


get raspberry pi os lite from
https://www.raspberrypi.org/software/operating-systems/

mount the partitions

    go run main.go ./2021-05-07-raspios-buster-armhf-lite-firstboot.img


boot partition:

touch /boot/ssh
cp firstboot.sh ./mnt/boot/firstboot.sh


./mnt/etc/ssh/sshd_config
PasswordAuthentication no
PermitRootLogin no

./mnt/etc/shadow
pi: USE password.py to generate


# even if user is not pi, put it in /home/pi, the system will rename it
sudo cd /mnt/home/pi
sudo mkdir .ssh
sudo chmod 0700 .ssh
sudo chown 1000:1000 .ssh
sudo add keys to .ssh/authorized_keys
sudo chown 1000:1000 .ssh/authorized_keys
sudo chmod 0600 .ssh/authorized_keys

dnsmasq

- https://wiki.ubuntuusers.de/PXE-Installation/#Bootimage-vorbereiten
- gateway (https://blag.felixhummel.de/basics/networking.html#nat-dhcp-and-dns)
    - ``iptables -t nat -I POSTROUTING -j MASQUERADE``
    - ``echo 1 > /proc/sys/net/ipv4/ip_forward``
    - ``/etc/sysctl.conf``

weiter

- https://help.ubuntu.com/community/PXEInstallServer

debug

- http://ipxe.org/cmdline
    - C-b
    - ``dhcp``
    - ``route``
- boot fails?
    - right Ctrl + F4 (syslog

https://hugoheden.wordpress.com/2009/02/24/dnsmasq-and-etchosts/

memdisk is nogo :( https://www.reddit.com/r/linux/comments/pasyf/can_i_boot_iso_files_from_pxetftp/?st=iu056ams&sh=560e4216

xenial-updates 404

- http://archive.ubuntu.com/ubuntu/dists/xenial-updates/
- https://help.ubuntu.com/community/Rsyncmirror

hangs when trying to fetch security.ubuntu.com (F2, ps):

- https://help.ubuntu.com/lts/installation-guide/example-preseed.txt

mirror xenial:

rsync --progress -a rsync://de.archive.ubuntu.com/ubuntu/dists/xenial-backports files/ubuntu-16.04.1-server-amd64/dists/
rsync --progress -a rsync://de.archive.ubuntu.com/ubuntu/dists/xenial-security files/ubuntu-16.04.1-server-amd64/dists/
rsync --progress -a rsync://de.archive.ubuntu.com/ubuntu/dists/xenial-updates files/ubuntu-16.04.1-server-amd64/dists/

ok, wir brauchen einen mirror (oder netz beim install)

mirror hat ca 70GB: https://wiki.ubuntuusers.de/apt-mirror/

stuff we need
=============
- 2 VMs
    - ``pxe`` is the dnsmasq [DHCP, TFTP, NAT, HTTP] server
    - ``pxe-booter`` is configured to boot from HDD, then PXE (for reboots).
      Used for testing.
- salt on ``pxe`` to configure
    - dnsmasq
    - files on {/var/lib/tftpboot,/var/www}
    - nginx (to serve cfg and optionally the ubuntu mirror)


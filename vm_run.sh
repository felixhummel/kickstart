#!/bin/bash
set -euo pipefail

box=ubuntu-16.04.1-server-amd64-ks
iso=${box}.iso
ssh_port=9222

set -x
vboxmanage createvm --name $box --ostype Ubuntu_64 --register
# cd
vboxmanage storagectl $box --name IDE --add ide --controller PIIX4 --portcount 2
vboxmanage storageattach $box --storagectl IDE --type dvddrive --device 0 --port 0 --medium $iso
# hdd
vboxmanage createmedium disk --filename ${box}.vdi --size 40000 --format VDI
vboxmanage storagectl $box --name SATA --add sata --controller IntelAHCI --portcount 1
vboxmanage storageattach $box --storagectl SATA --type hdd --device 0 --port 0 --medium ${box}.vdi

vboxmanage modifyvm $box --nic1 nat
vboxmanage modifyvm $box --natpf1 "guestssh,tcp,,9222,,22"
vboxmanage modifyvm $box --memory 4096
vboxmanage modifyvm $box --cpus 3

vboxmanage startvm $box

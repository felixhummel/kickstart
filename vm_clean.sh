#!/bin/bash
box=ubuntu-16.04.1-server-amd64-ks

# stop vm if running
vboxmanage list runningvms | grep -q $box && vboxmanage controlvm $box poweroff

# remove VM and force deletion of the medium (if unregistervm fails somehow)
vboxmanage unregistervm $box --delete \
  || vboxmanage closemedium ubuntu-16.04.1-server-amd64-ks.vdi --delete


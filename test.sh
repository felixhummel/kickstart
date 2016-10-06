#!/bin/bash
set -euo pipefail

# create the kickstart ISO and ks.cfg
make

# serve ks.cfg
python3 -mhttp.server 9080 &
pid=$!
finally() {
  kill $pid
}
trap finally EXIT SIGINT

# create and run the vm; this goes to the background automatically
./vm_run.sh

# should print "OK" and "Installation took N seconds"
./vm_wait_for_ssh.sh

./vm_clean.sh

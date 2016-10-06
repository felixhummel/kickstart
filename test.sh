#!/bin/bash
set -euo pipefail

# create the kickstart ISO and ks.cfg
make

# serve ks.cfg
python -mSimpleHTTPServer 9080 &

# create and run the vm; this goes to the background automatically
./vm_run.sh

# should print "OK" and "Installation took N seconds"
./vm_wait_for_ssh.sh


#!/bin/bash

# minutes to wait for installation
TIMEOUT=10
let timeout_seconds=$TIMEOUT*60

dt() { date +%s; }

t0=$(dt)

let t1=$t0+$timeout_seconds

echo "waiting $TIMEOUT minutes for SSH"

while true; do
  ./vm_ssh.sh 2>/dev/null && break || continue
  echo -n .
  sleep 1
  if [[ $(dt) > $t1 ]]; then
    echo  # newline
    echo "timeout"
    exit 1
  fi
done

echo  # newline
let diff=$(dt)-$t0
echo "Installation took $diff seconds"


#!/bin/bash
exec ssh \
       -o UserKnownHostsFile=/dev/null \
       -o StrictHostKeyChecking=no \
       -p 9222 \
       root@localhost \
       echo OK


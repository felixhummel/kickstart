What is this?
=============
Kickstart Ubuntu 16.04 with Virtualbox-based test.


How do I use this?
==================
::

    ./test.sh


What do I need to run this?
===========================
- Virtualbox (``which vboxmanage``)
- a good DHCP config, so a NATed VM can find your host by its FQDN
- free ports
    - 9080 to serve the Kickstart config
    - 9222 to forward SSH
- ``sudo``
- ``make``
- ``bash``
- ``python3``


Clean up please!
================
::

    make clean
    ./vm_clean.sh


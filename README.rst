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
- ``sudo``
- ``make``
- ``bash``
- ``python``


Clean up please!
================
::

    make clean
    ./vm_clean.sh


#!/bin/bash

/root/apps/getrules.sh
ln -s /etc/snort/so_rules/precompiled/Ubuntu-12-04/x86-64/* /usr/local/lib/snort_dynamicrules
mkdir -p /var/log/snort
cp /root/rules/* /etc/snort/rules

snort --daq pfring --daq-mode passive --daq-dir /usr/local/lib/daq -i eth1 -c /etc/snort/etc/snort.conf


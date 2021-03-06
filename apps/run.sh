#!/bin/bash

/root/apps/getrules.sh
ln -s /etc/snort/so_rules/precompiled/Ubuntu-12-04/x86-64/* /usr/local/lib/snort_dynamicrules
mkdir -p /var/log/snort
cp /root/rules/* /etc/snort/rules

snort --daq pfring --daq-mode passive --daq-dir /usr/local/lib/daq -i $DEVICE -c /etc/snort/etc/snort.conf -b -d --create-pidfile --pid-path=/var/run $1


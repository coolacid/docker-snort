docker-snort
============

Snort in a Docker Container

Install
============

- Install Docker - http://docs.docker.io/en/latest/installation/ubuntulinux/
- On the host: sudo apt-get install build-essential checkinstall autoconf bison flex libpcap-dev libpcre3-dev zlib1g-dev libnuma-dev libtool
- Clone the repo
- Go to the debs directory and run run.sh to build the deb requirements
- modprobe pf_ring and/or ensure it starts on startup
- make sure the eth1 (recommended) on the host is up
- configure the container by editing config.sh
- If everything works out correctly, you should be able to run the test.sh script and run snort using the /run.sh file

Notes
=====

- Snort rules update every 6 hours by default - see apps/updatesnort.py

Todo
====

- Support PF_RING cluster mode
- Should probably set the update time in config.sh

See More
========

- snort - http://www.snort.org/
- pf_ring - http://www.ntop.org/products/pf_ring/ ( http://sourceforge.net/projects/ntop/files/PF_RING/ )
- pf_ring Fork - https://github.com/xtao/PF_RING

Tip Jar: https://gist.github.com/coolacid/9537573
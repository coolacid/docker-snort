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
- make sure the eth1 (recommended) is up
- If everything works out correctly, you should be able to run the test.sh script and run snort using the /run.sh file

Todo
====

- Have signatures update regularly. One could do this by restarting the docker container. Not sure the best way to handle this yet.
- Use -v (Create a bind mount to a directory or file with: [host-path]:[container-path]:[rw|ro]) for log locations?

See More
========

- snort - http://www.snort.org/
- pf_ring - http://www.ntop.org/products/pf_ring/ ( http://sourceforge.net/projects/ntop/files/PF_RING/ )
- pf_ring Fork - https://github.com/xtao/PF_RING

Tip Jar: https://gist.github.com/coolacid/9537573
FROM ubuntu:12.04
MAINTAINER Jason Kendall

# (Optional) Set APT proxy
RUN echo 'Acquire::http { Proxy "http://10.0.10.10:8000"; };' > /etc/apt/apt.conf.d/99proxy

RUN apt-get update

RUN apt-get -y install iptables libnetfilter-queue1 libpcap0.8 libnet1 libnuma1

# Install from locally generated .deb files
ADD debs /root/
RUN dpkg -i /root/*.deb
RUN mv /root/daq_pfring.* /usr/local/lib/daq
RUN rm /root/*.deb
RUN cd /usr/local/lib && ln -s libdnet.1 libdnet.so.1
RUN ldconfig
ADD run.sh /
ADD apps /root/apps/
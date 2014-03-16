#!/bin/bash
LIBDNET="libdnet-1.12.tgz"
PFRING="PF_RING-5.6.0.tar.gz"
DAQ="2778"
SNORT="2787"
SPWD=`pwd`
CIOPTS="--install=no -y --pakdir=$SPWD"

build_libdnet() {
    wget https://libdnet.googlecode.com/files/$LIBDNET -O libdnet.tgz
    tar xvfvz libdnet.tgz
    cd libdnet*
    ./configure "CFLAGS=-fPIC"
    make
    checkinstall $CIOPTS
    cd ..
}

build_daq() {
    wget http://www.snort.org/downloads/$DAQ -O daq.tar.gz
    tar xvfvz daq.tar.gz
    cd daq*
    ./configure
    make
    checkinstall $CIOPTS
    cd $SPWD
}

build_snort() {
    wget http://www.snort.org/downloads/2787 -O snort.tar.gz
    tar xvfvz snort.tar.gz
    cd snort*
    ./configure
    make
    checkinstall $CIOPTS
    cd $SPWD
}

build_pfringlib() {
    # Something is wrong with this build - there is a fork available on github, we'll use that
    #    wget http://downloads.sourceforge.net/project/ntop/PF_RING/$PFRING -O pf_ring.tar.gz
    #    tar xfz pf_ring.tar.gz
    #    PFRINGVER=`ls | grep PF_RING | cut -f2 -d-`
    wget https://github.com/xtao/PF_RING/archive/master.zip -O pfring.zip
    unzip pfring.zip
    PFRINGVER="5.6.10"
    cd PF_RING*/userland/lib
    ./configure
    # Fix a small linker bug
    sed -i 's/-lpthread/-lpthread -lnuma -lrt/' Makefile
    make
    make install
    checkinstall $CIOPTS --pkgversion=$PFRINGVER --pkgname=pf-ring-lib
    cd $SPWD
}

build_pfringkern() {
    echo TODO: See if kernel module is there, if not, build and install it
}

build_pfringlibpcap() {
    cd $SPWD/PF_RING*/userland/
    PFRINGPCVER=`ls | grep libpcap- | cut -f2 -d-`
    cd libpcap
    ./configure
    make
    checkinstall $CIOPTS --pkgversion=$PFRINGPCVER
    cd $SPWD
}


build_pfringdaq() {
    cd $SPWD/PF_RING*/userland/snort/pfring-daq-module
    autoreconf -ivf
    ./configure
    make
    cp .libs/daq_pfring.so $SPWD
    cp daq_pfring.la $SPWD
    cd $SPWD
}


cleanup() {
    cd $SPWD
    rm *.tgz *.tar.gz *.zip
    find . -maxdepth 1 -mindepth 1 -type d -exec rm -R {} \;
}

build_libdnet
build_daq
build_snort
build_pfringlib
build_pfringkern
##build_pfringlibpcap  # Not really Needed
build_pfringdaq
cleanup

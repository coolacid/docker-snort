#!/bin/bash
source config.sh
docker build -t snort . 
docker run -privileged -i --entrypoint="/bin/bash" -e CUSTOMRULES="$CUSTOMRULES" -e OINKCODE="$OINKCODE" -e SUBSCRIBER="$SUBSCRIBER" -e DEVICE="$DEVICE" -v "$LOGPATH":/var/log/snort:rw -t snort -i 



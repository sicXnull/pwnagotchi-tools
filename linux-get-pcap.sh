#!/bin/sh
# Author: sic
INSTALL_LOCATION=~/Desktop

mkdir $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
ssh-keygen -t rsa
ssh-copy-id root@10.0.0.2
scp -r ~/.ssh/id_rsa.pub root@10.0.0.2:/home/pi/handshakes/*.pcap $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
scp -r ~/.ssh/id_rsa.pub root@10.0.0.2:/root/handshakes/*.pcap $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
rm $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap/*.pub

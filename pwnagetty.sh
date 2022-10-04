#!/bin/sh
# Author: sic
INSTALL_LOCATION=/home/sic/Desktop

echo "*** MUST BE RUN AS ROOT ***"

apt-get -y --allow-unauthenticated update  && apt-get install -y curl
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/h/hcxtools/hcxtools_6.0.2-1_amd64.deb
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && apt-get -y install nodejs
apt-get install -y ./libssl1.1_1.1.1f-1ubuntu2_amd64.deb
apt-get install -y ./hcxtools_6.0.2-1_amd64.deb
rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb hcxtools_6.0.2-1_amd64.deb
cd $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pwnagetty
npm install
node pwnagetty.js
chmod -R a+rwx $INSTALL_LOCATION/pwnagotchi-tools/handshakes/hccapx $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pmkid
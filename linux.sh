#!/bin/sh
# Author: sic
INSTALL_LOCATION=/home/sic/Desktop
HASHCAT_LOCATION=/home/sic/Desktop/hashcat-6.2.5
WORDLIST_LOCATION=/home/sic/Desktop/wordlist

echo "*** MUST BE RUN AS ROOT ***"

echo "DIR=$INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap/" >> $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pwnagetty/.env

cat <<EOT >> .env
PROJECT_PATH="$INSTALL_LOCATION/pwnagotchi-tools/"
HASHCAT_PATH="$HASHCAT_LOCATION/"
WORDLIST_PATH="$WORDLIST_LOCATION/"
SCRIPT_TYPE=".sh"
EOT

mkdir $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
ssh-keygen -t rsa
ssh-copy-id root@10.0.0.2
scp -r ~/.ssh/id_rsa.pub root@10.0.0.2:/home/pi/handshakes/*.pcap $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
scp -r ~/.ssh/id_rsa.pub root@10.0.0.2:/root/handshakes/*.pcap $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap
rm $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pcap/*.pub

apt-get -y --allow-unauthenticated update \
&& apt-get install -y curl python3-pip python3-dotenv
pip install wordninja tabulate
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/h/hcxtools/hcxtools_6.0.2-1_amd64.deb
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && apt-get -y install nodejs
apt-get install -y ./libssl1.1_1.1.1f-1ubuntu2_amd64.deb
apt-get install -y ./hcxtools_6.0.2-1_amd64.deb
rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb hcxtools_6.0.2-1_amd64.deb
cd $INSTALL_LOCATION/pwnagotchi-tools/handshakes/pwnagetty
npm install
npm install dotenv
node pwnagetty.js
cd $INSTALL_LOCATION/pwnagotchi-tools
python3 generate-hashcat-scripts.py
chmod -R a+rwx $INSTALL_LOCATION/pwnagotchi-tools/*
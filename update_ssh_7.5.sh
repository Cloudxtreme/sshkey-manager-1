#!/bin/bash
mgr_dir=`cd $(dirname $0);pwd`

source $mgr_dir/lib.sh

hint "The currect version of ssh:"
ssh -V

hint "Download package:"
wget https://launchpadlibrarian.net/335526589/openssh-client_7.5p1-10_amd64.deb
wget https://launchpadlibrarian.net/298453050/libgssapi-krb5-2_1.14.3+dfsg-2ubuntu1_amd64.deb
wget https://launchpadlibrarian.net/298453058/libkrb5-3_1.14.3+dfsg-2ubuntu1_amd64.deb
wget https://launchpadlibrarian.net/298453060/libkrb5support0_1.14.3+dfsg-2ubuntu1_amd64.deb


hint "dpkg package:"
sudo dpkg -i libkrb5support0_1.14.3+dfsg-2ubuntu1_amd64.deb
sudo dpkg -i libkrb5-3_1.14.3+dfsg-2ubuntu1_amd64.deb
sudo dpkg -i libgssapi-krb5-2_1.14.3+dfsg-2ubuntu1_amd64.deb
sudo dpkg -i openssh-client_7.5p1-10_amd64.deb



hint "The currect version of ssh:"
ssh -V

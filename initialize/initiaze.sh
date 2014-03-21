#!/bin/bash
#program
# This ruby on rails deployment script

function check {
command -v $1
if [[ "$?" -eq 1  ]]; then
echo " Execute the $1  fails "
$2
exit 0
fi	
}

function install_ruby {
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel

echo 'installing rvm ....'
curl -L get.rvm.io | bash -s stable
echo "/etc/profile.d/rvm.sh" >> ~/.bashrc
source ~/.bashrc
source ~/.profile
check "rvm -v" "install_ruby"
rvm install 1.9.3
rvm use 1.9.3 --default
check "rails -v" "gem install rails"
}

check "ruby -v" "install_ruby"

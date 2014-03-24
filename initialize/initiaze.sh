#!/bin/bash
#program
# This ruby on rails deployment script

function check {
echo "run $1"
command -v $1
if [[ "$?" -ne 0 ]]; then
echo " Execute the $1  fails "
$2
fi	
}

function install_rvm {
sudo yum update 
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel
echo 'installing rvm ....'
curl https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
source ~/.profile
echo 'install over'
}

function install_ruby {
sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
rvm install 1.9.3
echo "/bin/bash --login" >> ~/.bashrc
source ~/.bashrc
check "ruby -v" "install_ruby"
rvm use 1.9.3 --default
check "rails -v" "gem install rails"
}

check "rvm -v" "install_rvm"
check "ruby -v" "install_ruby"

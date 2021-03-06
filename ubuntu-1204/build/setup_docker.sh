#!/bin/bash

set -x
set -e

echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

apt-get update
apt-get upgrade -y


# install standard tools
apt-get install -y --no-install-recommends \
	bash-completion \
	bzip2 dnsutils \
	less \
	netcat-traditional \
	patch \
	time \
	traceroute \
	w3m \
	curl \
	wget \
	whiptail \
	whois \
	telnet \
	net-tools \


# install various helper tools
apt-get install -y --no-install-recommends \
	vim \
	nethogs \
	pv \
	git \
	rsync \
	iotop \
	sysstat \
	ngrep \
	mc \
	sudo \
	locales \
	man \
	apt-transport-https \
	unzip \
	strace \
	gnupg \

# install acl to support advanced file permissions
apt-get install -y --no-install-recommends acl

# install ssh client
apt-get install -y --no-install-recommends openssh-client

# configure user project
useradd -d /home/project -m -s /bin/bash -u 1000 -U project
echo 'project:project' | chpasswd
echo 'project ALL=NOPASSWD: ALL' >> /etc/sudoers

# add debian-repo.nfq.lt key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5791B856FE7BB48D

apt-get install -y --no-install-recommends cowsay
ln -s /usr/games/cowsay /usr/local/bin/

# Generate locales
echo en_US.UTF-8 UTF-8 > /var/lib/locales/supported.d/local
dpkg-reconfigure locales
echo LC_ALL=en_US.UTF-8 > /etc/default/locale

cp -frv /build/files/* /


source /usr/local/build_scripts/cleanup_apt.sh


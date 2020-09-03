#!/bin/bash

packages_to_install=('build-essential')

# Note: do NOT install 'npm' 'nodejs' because nvm or n will manage those instead.

sudo echo # forces activation of sudo rights, so prompts won't appear later when not watching..

[[ `dpkg -s nodejs 1>/dev/null 2>/dev/null` ]] && echo "I will uninstall nodejs in favor of 'n' (Ctrl-C to cancel script)"
[[ `dpkg -s npm 1>/dev/null 2>/dev/null` ]] && echo "I will uninstall npm  in favor of 'n' (Ctrl-C to cancel script)"
echo "apt-get update --yes"
echo "apt-get upgrade --yes"
read -p "run apt-get update and upgrade?" -n 1 -r
update=$REPLY
echo

read -p "Install Kimball's preferred apps and settings? (gvim, gtk, zsh, etc) (y/n)?" -n 1 -r
kimballPrefs=$REPLY
echo

echo 
echo "Proposed packages to install: ${packages_to_install[@]}"
read -p "Install packages listed above?: " -n 1 -r
installPkgs=$REPLY
echo

if [[ $update =~ ^[Yy]$ ]]
then
	sudo apt-get update --yes
	sudo apt-get upgrade --yes
	[[ `dpkg -s nodejs` ]] && sudo apt-get remove nodejs --yes
	[[ `dpkg -s npm` ]] && sudo apt-get remove npm --yes
fi

if [[ $kimballPrefs =~ ^[Yy]$ ]]
then
	#packages_to_install=('zsh' 'vim-gtk3' 'dbus-x11' "${packages_to_install[@]}")
	[[ ! -e ~/.oh-my-zsh ]] && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	echo "running apt-get to install packages..."
	sudo apt-get --yes install zsh vim-gtk3
	if [[ ! `awk -F: -v u="$USER" 'u==$1&&$0=$NF' /etc/passwd` =~ zsh ]]; then
		echo 'changing default shell to zsh: may require password'
		sudo chsh -s $(which zsh)
	fi

	#cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi

if [[ $installPkgs =~ ^[Yy]$ ]]
then
	sudo apt-get install "${packages_to_install[@]}"
fi

if [[ ! -d $HOME/n ]]; then
	echo "Attempting to install 'n', the nodejs version manager (not detected in $HOME)"
	curl -L https://git.io/n-install | bash
else
	echo "n (node version manager) is already installed."
fi

curl -L https://itcentral.chgcompanies.com/confluence/download/attachments/11109664/.chg-ssh-aliases?version=1&modificationDate=1578074220283&api=v2&download=true --fail -o .chg-ssh-aliases2

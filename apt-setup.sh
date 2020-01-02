sudo apt-get update --yes
sudo apt-get upgrade --yes
packages_to_install = ('npm' 'nodejs')
read -p "Install Kimball's preferred apps (gvim, gtk, zsh, etc) (y/n)?" -n 1 -r
echo  
if [[ $REPLY =~ ^[Yy]$ ]]
then
	packages_to_install=('zsh' 'vim-gtk3' 'dbus-x11' "${packages_to_install[@]}")
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	sudo apt-get --yes install zsh vim-gtk3 dbus-xll
	#cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi
sudo apt-get install "${packages_to_install[@]/#/-}"

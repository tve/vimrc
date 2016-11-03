#! /bin/bash

echo ${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p $XDG_CONFIG_HOME

today=`date +%Y%m%d`
nvim="${XDG_CONFIG_HOME}/nvim"
if [[ -e $nvim && ! -L $nvim ]]; then
  echo "Backing up existing neovim config"
  mv $nvim $nvim.$today
fi

echo "Creating symlink"
rm -f $nvim
ln -s $PWD $nvim

echo "Installing plugins"
curl -fLo ${nvim}/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing python hell"
sudo apt-get install -y python3-dev python3-pip
sudo pip3 install neovim

nvim -u plugins.vim +PlugInstall +qall
nvim -u init.vim +UpdateRemotePlugins +qall

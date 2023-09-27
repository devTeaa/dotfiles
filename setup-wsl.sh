#!/bin/bash
sudo apt update
# Install all package
sudo apt install tmux ranger git vim curl wget zsh

# Install Nvm
# curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# nvm install 12
# nvm install 14
# nvm install 16
# nvm install 18
# nvm install 20

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Mount directory
# ln -s /mnt/d/_repos _repos
# ln -s /mnt/d/_self _self

ssh-keygen -t ed25519 -C "devtea@protonmail.com" -f ~/.ssh/github
ssh-keygen -t ed25519 -C "devtea@protonmail.com" -f ~/.ssh/gitlab
ssh-keygen -t ed25519 -C "devtea@protonmail.com" -f ~/.ssh/ibmcloud

# Set permissions for ssh config
cat > ~/.ssh/config << EOF
AddressFamily inet

Host github.com
  HostName github.com
  IdentityFile ~/.ssh/github

Host gitlab.com
  HostName gitlab.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/gitlab

Host us-south.git.cloud.ibm.com
  HostName us-south.git.cloud.ibm.com
  IdentityFile ~/.ssh/ibmcloud
EOF

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

# Install vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

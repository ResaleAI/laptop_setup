#!/bin/sh

echo 
# Install VS Code
curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode.deb
sudo apt install ./vscode.deb

# install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc

# install and use npm
nvm install 10
num use 10

# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn

# install git-flow
sudo apt-get git-flow

# install heroku cli
curl https://cli-assets.heroku.com/install.sh | sh

# install rbenv
sudo apt install ruby-build
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
~/.rbenv/bin/rbenv init
source ~/.bashrc
rbenv install 2.5.3

#!/bin/sh
# bash -c "$(curl -fsSL https://github.com/ResaleAI/laptop_setup/raw/master/rubydev_wsl.sh)"
$rubyversion = "2.3.4"
$railsversion = 5.1.1
echo "Installing dependencies"
sudo apt-get --assume-yes -qq update
sudo apt-get --assume-yes -qq install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs openssh-server qt5-default libqt5webkit5-dev xvfb libmagickwand-dev
cd
if [ ! -d ~/.rbenv ] ; then
    echo "Installing rbenv"
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    export PATH="$HOME/.rbenv/bin:$PATH"
    rbenv init -
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi
if [ ! -d ~/.rbenv/versions/${rubyversion}/ ]; then
    echo "Installing ruby $rubyversion"
    rbenv install $rubyversion
fi
rbenv global $rubyversion
find ~/.bundle/cache -type d -exec chmod 0755 {} +
gem install bundler
gem install rails -v $railsversion
rbenv rehash
if ! [ -x "$(command -v heroku)" ]; then
    echo "Installing heroku"
    sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
    curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
    sudo apt-get -qq update
    sudo apt-get -qq install heroku
fi
# Get SSH Server running 
sudo sed -i -e 's/#ListenAddress 0\.0\.0\.0/ListenAddress 0\.0\.0\.0/g' /etc/ssh/sshd_config
sudo sed -i -e 's/UsePrivilegeSeparation yes/UsePrivilegeSeparation no/g' /etc/ssh/sshd_config
sudo sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i -e 's/Port 22/Port 2222/g' /etc/ssh/sshd_config
sudo service ssh restart
# Work to get capybara-webkit tests running
echo "export DISPLAY=:0.0" >> ~/.bashrc
sudo sed -i 's$<listen>.*</listen>$<listen>tcp:host=localhost,port=0</listen>$' /etc/dbus-1/session.conf
ruby -v
rails -v

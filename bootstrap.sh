#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode
xcode-select --install
xcodebuild -license

# Install MacPorts
cd /tmp
curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.3.1.tar.bz2
tar xf MacPorts-2.3.1.tar.bz2
cd MacPorts-2.3.1
./configure
make
sudo make install

# Install MacPorts packages
while read line; do
  port=`echo $line | awk '{print $1'}`
  sudo port install "$port"
done < ~/.dotfiles/ports.txt

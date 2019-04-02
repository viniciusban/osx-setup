#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Configure and install softwares in OS X through command line.
# Author: @viniciusban
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# License TL;DR:
# You can do anything with this code, but you cannot hold the author liable.
#
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Viniciusban.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------


# Before running this script you must:
# - Install XCode from AppStore.
# - Open XCode and agree with its license or, from command line: `sudo xcrun cc`


# Create basic directories
# ------------------------

cd ~
mkdir -p ~/projects
mkdir -p ~/virtualenvs


# Install Homebrew (http://brew.sh) and Cask (http://caskroom.io)
# ---------------------------------------------------------------

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install caskroom/cask/brew-cask
brew tap homebrew/dupes  # to install screen with 256 colors support


# Let's make them work...
# Note: probably you'll be asked for your password a few times.


# Basic command line packages
# ---------------------------

brew install wget
brew install tree
brew install git
brew install ag ack


# libxml
# ------

brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force


# Python
# ------

brew install python3


# Pep8 related
# ------------

git clone git@github.com:google/yapf.git ~/projects/yapf


# The power of terminal!
# ----------------------

brew install tmux
brew cask install iterm2

# fix MacOS allowing softwares under tmux to interact with system clipboard
brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste


# Sqlite3 related
# ---------------

brew install sqlite3
brew cask install sqlitestudio


# The Editor!
# -----------

brew install vim
brew install macvim
brew link macvim


# Virtualisation
# --------------

# brew cask install virtualbox
# brew cask install vagrant
# VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0  # fix dhcp conflict: https://github.com/mitchellh/vagrant/issues/3083


# Audio and video tools
# ---------------------

# brew install libav  # avconv, avprobe...
# pip install youtube-dl


# Other
# -----

brew cask install transmission
brew cask install firefox
brew cask install dropbox
brew cask install libreoffice
brew cask install dash
brew cask install filezilla
brew cask install the-unarchiver # extract many compressed files
brew install ctags # exuberant-ctags on Mac, to use with vim.


# Markdown
# --------

brew cask install qlmarkdown  # Quick look markdown files in Finder
# Allow copy text from preview window
defaults write com.apple.finder QLEnableTextSelection -bool true


# Keyboard
# --------

brew cask install keycastr  # show pressed key in a HUD.
brew cask install captin  # show capslock status in menu bar.
brew cask install karabiner-elements  # keyboard remapping tool


# Cache ssh key password for an hour
# ----------------------------------

# Actually, remove ssh keys from ssh-agent every hour.
#
# 1. I don't want it to be stored in keychain. Keychain stores your
# passphrase forever. It doesn't ask you it anymore. I don't want it.
#
# Note: it seemd MacOS Sierra fixes it. But I don't tested.
#
# 2. I want it to have a cache lifetime (e.g., 1 hour).
#
# I followed [instructions from Apple](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/10000172i-SW7-BCIEDDBJ)
# and created
# `~/Library/LaunchAgents/com.viniciusban.ssh-agent-remove-key.plist` to
# run each 3600 seconds (1 hour) as a user agent.
#
# For more details see:
# - $ man ssh-add -d
# - http://www.dribin.org/dave/blog/archives/2007/11/28/ssh_agent_leopard/
#
# So, I ssh-agent caches my passphrase and this process removes it each hour.


mkdir -p ~/Library/LauchAgents
cd !$
cat >com.viniciusban.ssh-agent-remove-key.plist <<EOD
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<!-- https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/10000172i-SW7-BCIEDDBJ -->
<dict>
	<key>Label</key>
	<string>com.viniciusban.ssh-agent-remove-key</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/ssh-add</string>
		<string>-d</string>
	</array>
    <key>StartInterval</key>
    <integer>3600</integer> <!-- seconds -->
</dict>
</plist>
EOD


# Save battery life spinning down hard disks after 5 min of inactivity.
# I don't know why, but my default was 0 (don't spin down).
sudo pmset -b disksleep 5


# Now you must install manually from AppStore:
# - Marko  # markdown preview
# - Telegram  # the OS X client
# - Billing Timer  # A simple timer
# - iVinci Express  # graphics editor

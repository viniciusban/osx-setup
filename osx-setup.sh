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


# Let's make them work...
# Note: probably you'll be asked for your password a few times.


# Basic command line packages
# ---------------------------

brew install wget
brew install tree
brew install git


# Python
# ------

brew install python
brew install python3

pip install virtualenv  # for Python 2 only.


# Pep8 related
# ------------

# sudo pip install pep8
# sudo pip install autopep8
git clone git@github.com:google/yapf.git ~/projects/yapf


# The power of terminal!
# ----------------------

# brew install tmux
# brew cask install iterm2


# Sqlite3 related
# ---------------

brew install sqlite3
# brew cask install https://raw.githubusercontent.com/viniciusban/brew-casks/master/casks/sqlitestudio.rb


# The Editor!
# -----------

brew install vim
brew install macvim --with-python3
brew linkapps macvim


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
# brew cask install filezilla
# brew cask install skype
# brew cask install alinof-timer
# brew cask install flycut  # clipboard manager
# brew cask install the-unarchiver # extract many compressed files
# brew install cookiecutter


# Markdown
# --------

brew cask install qlmarkdown  # Quick look markdown files in Finder
# Allow copy text from preview window
defaults write com.apple.finder QLEnableTextSelection -bool true


# reStructuredText
# ----------------

# Online reStructuredText editor and preview
git clone https://github.com/anru/rsted.git ~/projects/rsted
cd ~/projects/rsted
virtualenv ~/virtualenvs/rsted
source ~/virtualenvs/rsted/bin/activate
pip install -U pip setuptools
pip install -r pip-requirements.txt
deactivate



# Macvim keyboard
# ---------------

# brew cask install karabiner # keyboard remapping tool
#
# # config to Karabiner remap Right Command Key to Control in macvim
# cat >~/Library/Application\ Support/Karabiner/private.xml <<EOD
# <?xml version="1.0"?>
# <root>
#     <appdef>
#         <appname>MacVim</appname>
#         <equal>org.vim.MacVim</equal>
#     </appdef>
#
#     <item>
#         <name>MacVim: Right Command key emulates CONTROL</name>
#         <identifier>private.right_command_to_control_l_in_macvim</identifier>
#         <only>
#             MacVim
#         </only>
#         <autogen>
#             __KeyToKey__ KeyCode::COMMAND_R, KeyCode::CONTROL_L
#         </autogen>
#     </item>
# </root>
# EOD


# Meslo font
# ----------

cd ${TMPDIR}
git clone https://github.com/andreberg/Meslo-Font.git meslo
cd meslo/dist/v1.2.1
unzip Meslo\ LG\ v1.2.1.zip
cp -r Meslo\ LG\ v1.2.1 ~/Library/Fonts/Meslo


# Now you must install manually from AppStore:
# - Marko  # markdown preview
# - Telegram  # the OS X client
# - Billing Timer  # A simple timer
# - iVinci Express  # graphics editor

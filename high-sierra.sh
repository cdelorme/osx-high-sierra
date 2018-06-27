#!/bin/bash -e

# expect sudo privileges and keep them active while the script executes
echo "this script will require sudo privileges..."
sudo echo "beginning automated setup of osx sierra..."
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# generate ed25519 key if none exists
[ ! -s ~/.ssh/id_ed25519 ] && ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519

# headless install of xcode command line tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# install homebrew if it is not already installed
which brew &> /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install homebrew packages
brew tap caskroom/cask
brew cask install qlmarkdown
brew cask install osxfuse
brew cask install vagrant
brew cask install java
brew install bzr
brew install awscli
brew install jq
brew install tmux
brew install reattach-to-user-namespace
brew install wget
brew install sshfs
brew install mercurial
brew install svn
brew install bash
brew install bash-completion
brew install vim --with-override-system-vi
brew install git
brew install packer
brew install graphicsmagick
brew install imagemagick
brew install ffmpeg --with-fdk-aac --with-libass --with-libssh --with-libvidstab --with-openjpeg --with-openssl --with-rtmpdump --with-tools --with-webp --with-x265 --with-fontconfig --with-freetype --with-libbluray --with-libcaca --with-libvorbis --with-libvpx --with-speex --with-theora --with-game-music-emu --with-openh264
brew install mpv --with-bundle
brew install jpeg-turbo
brew install faac
brew install swftools

# add and switch default shell to the homebrew bash
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells > /dev/null
chsh -s "$(brew --prefix)/bin/bash"

# clone repo and install configuration files
rm -rf /tmp/osx-high-sierra
git clone https://git.caseydelorme.com/cdelorme/osx-high-sierra /tmp/osx-high-sierra
sudo rsync -PrltODv /tmp/osx-high-sierra/root/ /
rsync -Pav /tmp/osx-high-sierra/user/ ~/

# install youtube-dl
if ! which youtube-dl &> /dev/null; then
	rm -rf /usr/local/bin/youtube-dl
	sudo curl -Lo /usr/local/bin/youtube-dl "https://yt-dl.org/downloads/latest/youtube-dl"
	sudo chmod +x /usr/local/bin/youtube-dl
	sudo chown $USER:$USER /usr/local/bin/youtube-dl
fi

# enable crontab
[ -f ~/.crontab ] && crontab ~/.crontab && rm ~/.crontab

# install gvm leveraging ~/.bash_profile
if [ ! -d ~/.gvm ]; then
	GVM_NO_UPDATE_PROFILE=1 bash < <(curl -Ls https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer 2>& /dev/null)
	grep "gvm" ~/.bash_profile &> /dev/null || echo ". ~/.gvm/scripts/gvm" >> ~/.bash_profile
fi

# install the latest go
if ! which go &>/dev/null; then
	. ~/.gvm/scripts/gvm
	gvm install go1.10.3 -B
	gvm use go1.10.3 --default
fi

# add sublime text shortcut even if it does not exist
sudo ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

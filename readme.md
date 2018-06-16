
# osx high sierra

This repository houses configuration files, scripted automation, and documentation regarding how I setup OSX High Sierra.


## installation

Installation takes roughly 20 minutes and involves at least one reboot.

One of the many new features is APFS, a newer file system to select instead of HFS+.

An option is available during the post-boot process to setup FileVault.  _I choose not to at this time, because historically the updates after installation may require you to decrypt the drive first, which is time consuming._

There is an option now to enable Siri; _I choose to leave this disabled since I use my laptop as a workstation not a dictation machine or mobile device._

There is an option to enter your Apple ID to setup iCloud.  _I choose not to, as the default storage space is too small to hold anything meaningful, and I don't care for the alarms or $0.99 monthly service fee._

## updates

Run updates right away to ensure all software is at the latest version.

_This may require multiple reboots; be sure to reboot and check the `App Store` for further updates._


## automation

I wrote an [automated script](https://git.caseydelorme.com/cdelorme/osx-high-sierra/master/high-sierra.sh) to quickly process terminal commands:

	curl -Ls0- "https://git.caseydelorme.com/cdelorme/osx-high-sierra/raw/master/high-sierra.sh" 2> /dev/null | bash

_The only recommendation I have is creating an application token in github and exporting the environment variable (`HOMEBREW_GITHUB_API_TOKEN`) before running the script._


### files

Besides documentation and scripts I have many files that I rely on this repository to load.

These files are organized into two structures in order to address dynamic user home folder:

- [user](user/)
- [root](root/)

These either add or supplement configuration.

_You are invited to peer through the contents._


### command line tools

You can manually trigger installation of command line tools like this:

	xcode-select --install

_No longer do you need to install all of XCode._


### generate an SSH Key

I recommend the newer `ed25519` format; similar level of security for significantly smaller data size:

	ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519

_You are welcome to generate one with a password, but unless multiple users have physical or remote access this offers little benefits._


### [gvm](https://github.com/moovweb/gvm)

I develop go software, so go version manager is exceptionally useful.


### [homebrew](https://brew.sh/)

**The first step, if you have a [github](https://github.com/) account, is to get an api key for homebrew to avoid rate limits.**

I install the following homebrew packages:

- caskroom/cask/qlmarkdown
- caskroom/cask/osxfuse
- caskroom/cask/vagrant
- caskroom/cask/java
- bzr
- awscli
- jq
- tmux
- reattach-to-user-namespace
- wget
- sshfs
- mercurial
- svn
- bash
- bash-completion
- vim
- git
- packer
- graphicsmagick
- imagemagick
- ffmpeg
- mpv
- jpeg-turbo
- faac
- swftools

_Many of these packages have additional flags set during installation._

The `reattach-to-user-namespace` package is to address a window targeting bug, specifically launching `subl .` from command line.


### crontab

By default I have a crontab setup to update homebrew, generate symbolic links for wallpaper (_since OSX is too dumb to recurse selected desktop background folders_), and to update `youtube-dl`.

I highly recommend adding a job to download `~/.ssh/authorized_keys` using registered public keys from a repository host, such as [github](https://github.com) or [gitlab](https://gitlab.com); specifically leveraging `/username.keys`.


### git

If you intend to use version control you should set your username and email:

	git config --global user.name "$github_name"
	git config --global user.email "$github_email"

_A pro tip, if you want to automatically infer ssh over https for github with your username:_

	git config --global url."git@github.com:$github_username".insteadOf "https://github.com/$github_username"


## software

Here is the software I download and install on my system:

- [Google Chrome](https://www.chromium.org/getting-involved/dev-channel)
- [iTerm3](http://www.iterm2.com/version3.html)
- [homebrew](http://brew.sh/)
- [Sublime Text](https://www.sublimetext.com/3)
- [VirtualBox + Extensions](https://www.virtualbox.org/)
- [Transmission](https://transmissionbt.com/download/)
- [Adobe Flash Projector](http://www.adobe.com/support/flashplayer/downloads.html)

The homebrew package manager saves the day when it comes to a myriad of support tools.  _It no-longer requires [XCode](https://itunes.apple.com/us/app/xcode/id497799835), but if you plan to use it you should install it first to avoid redundant license agreements._

Sublime Text is not free but is highly recommended.  **If you are a developer and can afford to buy a copy, you should.**

_While flash might cater to a dying industry, I like the option of being able to run `.swf` without a browser._  Copying the `.app` into `~/Applications` and setting up file association is relatively easy.

Most of these I launch at least once to verify and accept to open them, and to configure them.

Finally I add a symlink to the binary for terminal access:

	sudo ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl


### google chrome

I synchronize with my gmail account so I have a consistent experience across computers.


### iTerm3

I allow this to check for updates automatically; it is updated quite frequently.

I also open `Profiles` then the `Keys` tab to select "Load Preset" and use the "Natural Text Editing" option to enable proper hotkeys for traversing tokens (eg. cmd + arrow keys).

From `Profiles` the `Text` tab I change the font settings to `ForMateKonaVE` size `14`.

Next I import the [`Solarized High Contrast Dark`](https://gist.github.com/jvandellen/2892531) color scheme from `Profiles` under the `Colors` tab.

Finally, I may enable some level of transparency under `Profiles` in the `Window` tab.


### Transmission

In the settings:

- General
	- **Enable**: Automatically size window to fit all transfers
- Transfers
	- Adding
		- Default Location: Downloads
		- **Disable**: Display a window when opening a torrent file
		- **Disable**: Display a window when opening a magnet link
		- **Enable**: Watch for torrent files in: Downloads
	- Management
		- **Enable**: Stop seeding at ratio: 2.00
		- **Enable**: Remove from the transfer list when seeding completes
		- **Disable** all sounds
- Bandwidth
	- **Enable**:Download Rate: 300
	- **Enable**:Upload Rate: 25
- Peers
	- **Enable**: Ignore unencrypted peers

_Obviously, bandwidth choices will depend on your ISP and activity._


### sublime text

I generally enter my license first.

I install [sublime package control](https://packagecontrol.io/), and install the following:

- [Markdown Preview](https://github.com/revolunet/sublimetext-markdown-preview)
- [SublimeCodeIntel](https://github.com/SublimeCodeIntel/SublimeCodeIntel)
- [GoSublime](https://github.com/DisposaBoy/GoSublime)
- [Origami](https://github.com/SublimeText/Origami)

_I load [these configuration files](#) with my automation._


## dock

Having installed and configured services, I begin pruning the dock then add and organize the tools I plan to use most often.


## finder

Next I begin modifying `Finder` configuration to keep the system as usable as possible.  Using `CMD+j` on the desktop I can enable "Show Item Info" and adjust text size if needed.  Next from my home folder (`~`) the same `CMD+j` combination lets me enable the previous option and "Show Library Folder", plus I can switch to "List View" and enable "Always open in list view" plus "Browse in list view".  I also enable "Calculate all sizes".  Finally I click "Use as Defaults" to apply this setting across the system.

Next I use the `CMD+,` hotkey to open Finder Preferences and modify General settings, where I can enable Hard Disks and Connected Services then disable CDs, DVDs, and iPods.  I set new finder windows to open my home folder.  Under the Tags tab I disable all of them; these are not useful to me.  Next from the sidebar I enable Music, Pictures, and my home folder, disabling Recents, iCloud Drive, and AirDrop.  I also disable Back to My Mac and Bonjour Computers.  I disable Tags and make sure a solid checkmark is on Hard Disks so I can select the root drive.  Finally under the Advanced tab I enable Show all filename extensions and set the search scope to the current folder then disable warnings.


## preferences

Next I launch `System Preferences` to begin full custom configuration.

From `General` I switch to a Graphite & Dark color scheme and automatically hide menus.  I use small sidebar icons, clicking the scrollbar jumps to that location, disable closing windows when quitting applications (_this disrupts things like Sublime Text_), set recent documents to None, and disable handoff to iCloud.

From `Desktop & Screen Saver` I create and select `~/Pictures/wallpaper` as a folder to cycle backgrounds every minute at random.  I fit these to screen while setting black for the fill color.  I disable the screen saver.  I use "Hot Corners" specifically the upper right to show the desktop.

From `Dock` I shrink the icons a little, add a very minor magnification, and position them to the right.  I select manual tab preference.  I enable Minimize windows into application icon, switch to Scale effect, and automatically hide the dock.  I disable animating opening applications.

From `Mission Control` I disable automatic spaces rearranging; _this is incredibly disruptive and I have no idea how people operate using it_.  I also disable switching to a space with the application; often I go to a new desktop specifically to open a new disassociated window.  Finally I disable the "Show Dashboard" hotkey.

From `Language and Region` I enable 24-Hour Time.

From `Security & Privacy`, after unlocking it, I enable the firewall with stealth mode.

From `Spotlight` I disable all locations except for `Applications`, `Calculator`, `Conversion`, `Definition`, and `System Preferences`.  I also disable "Allow Spotlight Suggestions".  Next in the Privacy tab I add my user folder.

From `Notifications` I enable DND mode, and disable everything except specific applications, such as the calendar.

From `Energy Saver` I lengthen the duration the screen stays on to an hour when on the power adapter.  I disable Power Napping for both battery and power adapter.

From `Keyboard` I enable turn keyboard backlight off (to save power), and use `Modifier Keys` to change caps lock into a control key.  From Text I disable Smart Quotes and Dashes.  From Shortcuts under Keyboard I disable keyboard access and various related focus hotkeys.  I disable the launchpad hotkey to Turn Dock Hiding on/off.  Next I add an App Shortcut of `ctrl+alt+=` to `Zoom` for all applications, and an alternative for Google Chrome using `shift+ctrl+=` because of how Zoom now works on google chrome.

From `Trackpad` I disable Look up, and enable Tap to Click.  I enable Silent Click, switch to Firm, and disable Force Click haptic feedback.  Under `More Gestures` I disable Swipe between Pages and Launchpad, and enable App Expose.

From `Sound` I switch to Tink, and disable user interface sound effects.  I also enable Show volume in menu.

From `Internet Accounts` I synchronize my gmail, specifically contacts and calendar.

From `Bluetooth` I enable Show Bluetooth in menu.

From `Extensions` I disable Stocks and Reminders.  I also disable all the "Share Menu" options I have control over.

From `Sharing` I shorten the name of my machine.


## encryption

The final step is to enable FileFault so that the drive contents are encrypted.

_We save this for last because it takes an obscenely long time to complete (literally multiple days now) and drastically reduces disk performance while it runs._

On another note, if enabled during installation it may need to be decrypted and re-encrypted to handle FileFault updates; historically this happened and was very time consuming.

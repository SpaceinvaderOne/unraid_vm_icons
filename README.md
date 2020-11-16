# unraid_vm_icons

A docker container that downloads and installs additional custom VM icons to the Unraid VM Manager.
Please install this from the Unraid community applications plugin.

I hope that people will submit custom icons to this repo which once approved will be added to the icons available to download for all.

Usage

After install Container should be set to auto start so icons are synced everytime the server or array starts.

Basic
Unraid template settings
1. Choose which custom icons you want to be installed from the drop downs. (Windows, Linux macOS, FreeBSD based (pfSense Freenas etc), and 'Other' Oses )
2. Choose wether you want to keep the existing stock vm icons (recommended to keep)
   Setting this to no will remove the stock unraid vm icons from the vm manager.
3. Set wether all icons are redownloaded when container starts.
    Setting this as yes will clear all vm icons then redownload all choosen icons from github repo. 
    Setting to yes will on every start download any new icons in selected sections.
    (This is also useful if you deceide you no longer want a choosen section of icons anymore)
 The default is set to 'no'    
    
4. If your server has a beep speaker you can enable a tune to be played each time icons are synced. Yeah silly but fun! :)

Advanced settings (under show more settings)
1. You can set how long the container should wait before exiting after syncing icons (default 30 seconds)
Useful only to keep container running for longer if you need to bash into the container for debugging.

Other options dont change

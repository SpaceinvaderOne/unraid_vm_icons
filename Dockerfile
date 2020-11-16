FROM ubuntu:18.04
MAINTAINER SpaceinvaderOne
RUN apt-get update && apt-get -y install git bash beep rsync
COPY . /iconsync
VOLUME /unraid_vm_icons
VOLUME /config
CMD bash ./iconsync/icon_download.sh ; sleep 30
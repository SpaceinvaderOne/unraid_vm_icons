FROM ubuntu:18.04
MAINTAINER SpaceinvaderOne
RUN apt-get update && apt-get -y install wget bash rsync
COPY . /iconsync
VOLUME /unraid_vm_icons
VOLUME /icons
CMD ./iconsync/icon_download.sh || : && bash && tail -f /dev/null
FROM alpine:latest
MAINTAINER SpaceinvaderOne
RUN apk add --no-cache git bash beep rsync
COPY . /iconsync
VOLUME /unraid_vm_icons
VOLUME /config
CMD bash ./iconsync/icon_download.sh ; sleep 5

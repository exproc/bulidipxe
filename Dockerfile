FROM nginx:1.27.1-bookworm

## Upgrade Existing Packages
RUN apt-get update && apt-get -y upgrade

## For apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


## Install packages
RUN apt-get install -y binutils-dev zip cron binutils-aarch64-linux-gnu binutils-x86-64-linux-gnu dosfstools figlet gcc-aarch64-linux-gnu gcc-x86-64-linux-gnu build-essential genisoimage git isolinux liblzma-dev libslirp-dev mtools syslinux syslinux-common toilet

## Copy Custom Files To Usr/share/nginx/html
#COPY usr/  /usr/share/nginx/html/

## Prepare html
RUN rm /usr/share/nginx/html/index.html
#COPY html/ /usr/share/nginx/html/
RUN mkdir /usr/share/nginx/html/bin

## Adding scripts and files
COPY config-backup /config-backup
COPY renew.sh /renew.sh
RUN chmod +x /renew.sh

## Copy Custom Nginx.conf to /etc/nginx
COPY nginx/ /etc/nginx/

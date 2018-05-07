FROM lsiobase/ubuntu.armhf:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="1.0"
LABEL maintainer="dynomitecentral"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

RUN \
 apt-get update && \
 apt-get install -y \
	apt-transport-https \
	avahi-daemon \
	dbus \
	udev \
	unrar \
	wget && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 44C25C58 && \
 echo "deb https://pmsb.dynodev.ga/repo/ jessie main" >> /etc/apt/sources.list.d/plex.list && \
 echo "**** install plexmediaserver ****" && \
 apt-get update && \
 apt-get install -y \
	plexmediaserver-installer && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode

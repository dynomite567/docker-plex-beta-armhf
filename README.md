# dynomitecentral/plex-beta-armhf
[![](https://images.microbadger.com/badges/version/dynomitecentral/plex-beta-armhf.svg)](https://microbadger.com/images/dynomitecentral/plex-beta-armhf "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/dynomitecentral/plex-beta-armhf.svg)](https://microbadger.com/images/dynomitecentral/plex-beta-armhf "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/dynomitecentral/plex-beta-armhf.svg)]() [![Docker Stars](https://img.shields.io/docker/stars/dynomitecentral/plex-beta-armhf.svg)]() [![Build Status](http://dns.dalpi.us:8080/job/docker-builds/job/plex-beta-armhf/badge/icon)](http://dns.dalpi.us:8080/job/docker-builds/job/plex-beta-armhf/)

**Forked from lsioarmhf/plex**

## Usage

```
docker create \
	--name=plex \
	--net=host \
	-e PUID=<UID> -e PGID=<GID> \
	-v </path/to/library>:/config \
	-v <path/to/tvseries>:/data/tvshows \
	-v </path/to/movies>:/data/movies \
	-v </path for transcoding>:/transcode \
	dynomitecentral/plex-beta-armhf
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - Plex library location. *This can grow very large.*
* `-v /data/xyz` - Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc.
* `-v /transcode` - Path for transcoding folder, *optional*.
* `-e PGID=` for for GroupID - see below for explanation
* `-e PUID=` for for UserID - see below for explanation

It is based on ubuntu xenial with s6 overlay, for shell access whilst the container is running do `docker exec -it plex /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Webui can be found at `<your-ip>:32400/web`

To update to the latest version, simply restart the docker container with `docker restart plex`

## Info

* Shell access whilst the container is running: `docker exec -it plex /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f plex`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' plex`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' lsioarmhf/plex`

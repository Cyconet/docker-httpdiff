# Docker-httpdiff

[![Build Status](https://travis-ci.org/Cyconet/docker-httpdiff.svg?branch=development)](https://travis-ci.org/Cyconet/docker-httpdiff)
[![Docker Build Status](https://img.shields.io/docker/build/waja/httpdiff.svg)](https://hub.docker.com/r/waja/httpdiff/)
[![GitHub tag](https://img.shields.io/github/tag/Cyconet/docker-httpdiff.svg)](https://github.com/Cyconet/docker-httpdiff/tags)
[![](https://img.shields.io/docker/pulls/waja/httpdiff.svg)](https://hub.docker.com/r/waja/httpdiff/)
[![](https://img.shields.io/docker/stars/waja/httpdiff.svg)](https://hub.docker.com/r/waja/httpdiff/)
[![](https://img.shields.io/docker/automated/waja/httpdiff.svg)](https://hub.docker.com/r/waja/httpdiff/)

Builds a docker image with the [httpdiff](https://github.com/jgrahamc/httpdiff) ready to run.

Running
-------

- run the docker container with:

```
docker run --rm -it waja/httpdiff --help 
```

Building
--------

```
make build
```

Get a shell in a running container
----------------------------------

```
make shell
```

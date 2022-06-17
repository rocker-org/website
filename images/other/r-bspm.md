---
title: r-bspm
---

## Quick reference

- Source repository: [rocker-org/rocker](https://github.com/rocker-org/rocker)
- Dockerfile
  - [rocker/r-bspm:testing](https://github.com/rocker-org/rocker/blob/master/r-bspm/testing/Dockerfile)
  - [rocker/r-bspm:22.04](https://github.com/rocker-org/rocker/blob/master/r-bspm/jammmy/Dockerfile)
  - etc.
- tags
  - [DockerHub](https://hub.docker.com/r/rocker/r-bspm/tags)
- Published image details: not available
- Non-root default user: `docker`

## Overview

[bspm](https://github.com/Enchufa2/bspm) configured containers.
Binary R packages can be easily installed.
Based on Debian, Ubuntu, Fedora, and OpenSUSE.

Similar to [`rocker/r-ubuntu`](r-ubuntu.md) in that these install R binary packages and system dependencies,
but thanks to bspm, these images automatically installs binary packages and system dependencies
even when using the R `install.packages()` function.

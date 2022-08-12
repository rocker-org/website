---
title: r-bspm
---

## Quick reference

- Source repository: [rocker-org/bspm](https://github.com/rocker-org/bspm)
- Dockerfile
  - [rocker/r-bspm:testing](https://github.com/rocker-org/bspm/blob/master/testing/Dockerfile)
  - [rocker/r-bspm:22.04](https://github.com/rocker-org/bspm/blob/master/jammy/Dockerfile)
  - etc.
- tags
  - [DockerHub](https://hub.docker.com/r/rocker/r-bspm/tags)
- Published image details: not available
- Non-root default user: `docker`

## Overview

[bspm](https://github.com/Enchufa2/bspm) configured containers.
Binary R packages can be easily installed.
Based on Debian, Ubuntu, Fedora, and OpenSUSE.

Similar to [`r-base`](https://hub.docker.com/_/r-base) and [`rocker/r-ubuntu`](r-ubuntu.md)
in that these can install R binary packages and system dependencies.
but thanks to bspm, `rocker/r-bspm` automatically installs binary packages and system dependencies
even when using the R `install.packages()` function.

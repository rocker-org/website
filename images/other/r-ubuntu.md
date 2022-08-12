---
title: r-ubuntu
---

## Quick reference

- Source repository: [rocker-org/ubuntu-lts](https://github.com/rocker-org/ubuntu-lts)
- [Dockerfile](https://github.com/rocker-org/ubuntu-lts/blob/master/jammy/Dockerfile)
- tags
  - [DockerHub](https://hub.docker.com/r/rocker/r-ubuntu/tags)
- Published image details: not available
- Non-root default user: `docker`

## Overview

Install current R and R packages on Ubuntu LTS,
from [PPA maintained by Michael Rutter](https://cloud.r-project.org/bin/linux/ubuntu/).
This image is close to [r-base](https://hub.docker.com/_/r-base).

You can use `apt` to install binary R packages (`r-cran-<package name>`) along with its dependencies,
as shown in the example below.

```sh
apt-get install -y --no-install-recommends r-cran-tidyverse
```

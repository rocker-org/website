---
title: r-devel, drd, drp
---

## Quick reference

- Source repository:
  - [rocker-org/r-devel](https://github.com/rocker-org/r-devel)
  - [rocker-org/drd](https://github.com/rocker-org/drd)
  - [rocker-org/drp](https://github.com/rocker-org/drp)
  - [rocker-org/r-devel-san](https://github.com/rocker-org/r-devel-san)
  - [rocker-org/r-devel-san-clang](https://github.com/rocker-org/r-devel-san-clang)
- Dockerfile
  - [rocker/r-devel](https://github.com/rocker-org/r-devel/blob/master/Dockerfile)
  - [rocker/drd](https://github.com/rocker-org/drd/blob/master/Dockerfile)
  - [rocker/drp](https://github.com/rocker-org/drp/blob/master/Dockerfile)
  - [rocker/r-devel-san](https://github.com/rocker-org/r-devel-san/blob/master/Dockerfile)
  - [rocker/r-devel-ubsan-clang](https://github.com/rocker-org/r-devel-san-clang/blob/master/Dockerfile)
- tags
  - rocker/r-devel
    - [DockerHub](https://hub.docker.com/r/rocker/r-devel/tags)
  - rocker/drd
    - [DockerHub](https://hub.docker.com/r/rocker/drd/tags)
  - rocker/drp
    - [DockerHub](https://hub.docker.com/r/rocker/drp/tags)
  - rocker/r-devel-san
    - [DockerHub](https://hub.docker.com/r/rocker/r-devel-san/tags)
  - rocker/r-devel-ubsan-clang
    - [DockerHub](https://hub.docker.com/r/rocker/r-devel-ubsan-clang)
- Published image details: not available
- Non-root default user: `docker`

## Overview

These images are based on [r-base](https://hub.docker.com/_/r-base) and
install [prerelease version of R from source](https://cloud.r-project.org/src/base-prerelease/),
separately from the release version of R.
These prerelease version R can be executed with `RD`(for R-devel) or `RP`(for R-patched).

- Both `rocker/r-devel` and `rocker/drd` are images for running R-devel;
  `rocker/drd` has a smaller image size because of the different Dockerfile configuration (layers).
- `rocker/drp` has R-patched installed.
- `rocker/r-devel-san` and `rocker/r-devel-ubsan-clang` provide R development binaries with Sanitizer support,
  for memory checking during R package development[^r-exts].
  `rocker/r-devel-san` uses clang, and `rocker/r-devel-ubsan-clang` uses gcc.

[^r-exts]: [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-devel/R-exts.html#Checking-memory-access)

:::{.callout-important}

`rocker/r-devel-ubsan-clang` must be use with
[`docker run`'s `--cap-add=SYS_PTRACE`](https://docs.docker.com/engine/reference/commandline/run/#options) option.
Otherwise, instrumented processes fail to start due to lacking permissions.

```sh
docker run --rm -ti --cap-add=SYS_PTRACE rocker/r-devel-ubsan-clang
```

Alternatively, an instrumented process can be run with `ASAN_OPTIONS=detect_leaks=0`,
but this turns off leak detection.

:::

:::{.callout-tip}

[`rocker/r-ver:devel`](../versioned/r-ver.md#devel),
[`rocker/rstudio:devel`, `rocker/tidyverse:devel`, `rocker/verse:devel`](../versioned/rstudio.md#devel)
also have R-devel installed.

:::

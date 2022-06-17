---
title: r-ver
---

## Quick reference

- Source repository: [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2)
- [Dockerfile](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/r-ver_devel.Dockerfile)
- tags
  - [DockerHub](https://hub.docker.com/r/rocker/r-ver/tags)
  - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/r-ver/versions)
- Published image details: [rocker-org/rocker-versioned2's wiki](https://github.com/rocker-org/rocker-versioned2/wiki)
- Non-root default user: not exist

## Overview

`rocker/r-ver` is alternate image to [`r-base`](https://hub.docker.com/_/r-base),
with an emphasis on reproducibility.

Compared to `r-base`,

- Builds on Ubuntu LTS rather than Debian and system libraries are tied to the Ubuntu version.
  Images will use the most recent LTS available at the time when the corresponding R version was released.
  - Since compatibility problems are likely to occur immediately after the release of a new Ubuntu LTS,
    the version to be used is the one that is at least 90 days past release.
    - `rocker/r-ver:4.0.0` is based on Ubuntu 20.04 (`ubuntu:focal`)
      because no interval was set at the time of the Ubuntu 20.04 release.
- Installs a fixed version of R itself from source, rather than whatever is already packaged for Ubuntu
  (the `r-base` stack gets the latest R version as a binary from Debian unstable).
- The only platforms available are `linux/amd64` and `linux/arm64`
  (arm64 images are experimental and only available for `rocker/r-ver` 4.1.0 or later).
- Set [the RStudio Public Package Manager (RSPM)](https://packagemanager.rstudio.com) as default CRAN mirror.
  For the amd64 platform, RSPM serves compiled Linux binaries of R packages and greatly speeds up package installs.
- Non-latest R version images installs all R packages from a fixed snapshot of CRAN mirror at a given date.
  This setting ensures that the same version of the R package is installed no matter when the installation is performed.
- Provides images that are generally smaller than the `r-base` series.

:::{.callout-note}

This document is for R 4.0.0 >= images.
Please check the [rocker-org/rocker-versioned](https://github.com/rocker-org/rocker-versioned) repository for R <= 3.6.3 images.

:::

## Spacial tags

### `devel`

The `devel` images are based on `ubuntu:latest` (the latest Ubuntu LTS version) and install [the latest R-devel daily snapshot](https://cloud.r-project.org/src/base-prerelease/).

### `cuda`

Tags which contain `cuda` (e.g. `rocker/r-ver:4.0.0-cuda10.1`) are alias of [`rocker/cuda`](cuda.md).

:::{.callout-warning}

cuda tags will be discontinued in the future, so please use `rocker/cuda` instead.

:::

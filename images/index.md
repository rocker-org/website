---
title: The Rocker Images
description: Choose a container for your needs.
---

## Overview

The Rocker Project provides a collection of (Linux) containers suited for different needs.
Find a base image to extend or images with popular software and optimized libraries pre-installed.

Get the latest version or a reproducibly fixed environment.

## Images

### The versioned stack

| image                                       | base image                                  | description                                                                    | pulls                                                                   |
|---------------------------------------------|---------------------------------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`rocker/r-ver`](versioned/r-ver.md)        | [`ubuntu`](https://hub.docker.com/_/ubuntu) | Install R from source and set RSPM as default CRAN mirror                      | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-ver)       |
| [`rocker/rstudio`](versioned/rstudio.md)    | `rocker/r-ver`                              | Adds RStudio Server                                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/rstudio)     |
| [`rocker/tidyverse`](versioned/rstudio.md)  | `rocker/rstudio`                            | Adds tidyverse packages & devtools                                             | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/tidyverse)   |
| [`rocker/verse`](versioned/rstudio.md)      | `rocker/tidyverse`                          | Adds tex & publishing-related package                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/verse)       |
| [`rocker/geospatial`](versioned/rstudio.md) | `rocker/verse`                              | Adds geospatial packages                                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/geospatial)  |
| [`rocker/binder`](versioned/binder.md)      | `rocker/geospatial`                         | Adds requirements to run repositories on [mybinder.org](https://mybinder.org/) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/binder)      |
| [`rocker/shiny`](versioned/shiny.md)        | `rocker/r-ver`                              | Adds shiny server                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny)       |
| [`rocker/shiny-verse`](versioned/shiny.md)  | `rocker/shiny`                              | Adds tidyverse packages                                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny-verse) |
| [`rocker/cuda`](versioned/cuda.md)          | `rocker/r-ver`                              | Adds CUDA support to `rocker/r-ver`                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/cuda)        |
| [`rocker/ml`](versioned/cuda.md)            | `rocker/cuda`                               | Adds CUDA support to `rocker/tidyverse`                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/ml)          |
| [`rocker/ml-verse`](versioned/cuda.md)      | `rocker/ml`                                 | Adds CUDA support to `rocker/geospatial`                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/ml-verse)    |

This stack builds on stable Debian releases (for R versions <= `3.6.3`) or Ubuntu LTS (for R versions >= `4.0.0`).
Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:3.4.0` for R `3.4.0`.
The `latest` tag always follows the latest release version of R.

Some images (e.g. `rocker/r-ver`) also have the `devel` tag, which installs the development version of R.

Version-tagged images are designed to be stable, consistently providing the same versions of all software
(R, R packages, system libraries) rather than the latest available
(though Debian system libraries will still recieve any security patches.)

See [the rocker-versioned2 repository](https://github.com/rocker-org/rocker-versioned2) for details.

### The base stack

| image                                                                                                     | base image                                          | description                                                | pulls                                                                                                                      |
|-----------------------------------------------------------------------------------------------------------|-----------------------------------------------------|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| [`r-base`](https://hub.docker.com/_/r-base)<br/>[`rocker/r-base`](https://hub.docker.com/r/rocker/r-base) | [`debian:testing`](https://hub.docker.com/_/debian) | Install current R from unstable repos                      | ![Docker Pulls](https://img.shields.io/docker/pulls/library/r-base.svg)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-base.svg) |
| [`rocker/r-devel`](https://hub.docker.com/r/rocker/r-devel)                                               | `r-base`                                            | R-devel added side-by-side onto r-base (using alias `RD`)  | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel.svg)                                                                |
| [`rocker/drd`](https://hub.docker.com/r/rocker/drd)                                                       | `r-base`                                            | Lighter `rocker/r-devel`                                   | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drd.svg)                                                                    |
| [`rocker/drp`](https://hub.docker.com/r/rocker/drp)                                                       | `r-base`                                            | R-pached added side-by-side onto r-base (using alias `RP`) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drp.svg)                                                                    |
| [`rocker/r-devel-san`](https://hub.docker.com/r/rocker/r-devel-san)                                       | `r-base`                                            | as `rocker/r-devel`, but built with compiler sanitizers    | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-san.svg)                                                            |
| [`rocker/r-devel-ubsan-clang`](https://hub.docker.com/r/rocker/r-devel-ubsan-clang)                       | `r-base`                                            | Sanitizers, clang c compiler (instead of gcc)              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-ubsan-clang.svg)                                                    |

This stack builds on `debian:testing` and Debian ustable repo.
Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.

`r-base` (Docker Official image) and `rocker/r-base` are built from the same Dockerfile,
but with different build systems.

See [the rocker repository](https://github.com/rocker-org/rocker) for details.

### Additional images

| image                                                         | base image                                                                | description                                                                                                       | pulls                                                        |
|---------------------------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| [`rocker/r-ubuntu`](https://hub.docker.com/r/rocker/r-ubuntu) | `ubuntu`                                                                  | Close to `r-base`, but based on `ubuntu`                                                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-ubuntu.svg) |
| [`rocker/r-bspm`](https://hub.docker.com/r/rocker/r-bspm)     | `r-base`, `rocker/r-ubuntu`, `archlinux`, `fedora`, `opensuse/tumbleweed` | Binary installation of R packages has been configured, powered by [bspm](https://cran.r-project.org/package=bspm) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-bspm.svg)   |

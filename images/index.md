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
| [`rocker/shiny`](versioned/shiny.md)        | `rocker/r-ver`                              | Adds shiny server                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny)       |
| [`rocker/shiny-verse`](versioned/shiny.md)  | `rocker/shiny`                              | Adds tidyverse packages                                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny-verse) |

This stack builds on stable Debian releases (for R versions <= `3.6.3`) or Ubuntu LTS (for R versions >= `4.0.0`).
Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:4.0.0` for R `4.0.0`.
The `latest` tag always follows the latest release version of R.

Some images (e.g. `rocker/r-ver`) also have the `devel` tag, which installs the development version of R.

Version-tagged images are designed to be stable, consistently providing the same versions of all software
(R, R packages, system libraries) rather than the latest available,
though Debian system libraries will still receive any security patches.
Please check [the document about versions](https://github.com/rocker-org/rocker-versioned2/wiki/Versions) for details.

## The Jupyter stack

This stack builds on official Jupyter instances.  This stack uses `r2u` + `bspm` mechanisms for fast R package installs with automatic dependency resolution, making these images easy to extend without knowledge of apt-get and system dependencies.

| image                                       | base image                                  | description                                                                    | pulls                                                                   |
|---------------------------------------------|---------------------------------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`rocker/binder`](versioned/binder.md)      | `quay.io/jupyter/minimal-notebook`          | JuyterHub compatible with `rocker/geospatial`, RStudio, VSCode interfaces      | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/binder)      |
| [`rocker/ml`](versioned/cuda.md)            | `quay.io/jupyter/minimal-notebook`          | JupyterHub compatible with RStudio, VSCode, + common python libraries          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/ml)          |
| [`rocker/cuda`](versioned/cuda.md)          | `quay.io/jupyter/pytorch-notebook:cuda12-ubuntu-24.04` | The `rocker/ml` recipe on a CUDA-12 base image                      | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/cuda)        |



### The base stack

| image                                                                             | base image                                          | description                                                | pulls                                                                                                                                              |
|-----------------------------------------------------------------------------------|-----------------------------------------------------|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| [`r-base`](https://hub.docker.com/_/r-base)<br/>[`rocker/r-base`](base/r-base.md) | [`debian:testing`](https://hub.docker.com/_/debian) | Install current R from unstable repos                      | ![Docker Pulls](https://img.shields.io/docker/pulls/library/r-base.svg)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-base.svg) |
| [`rocker/r-devel`](base/r-devel.md)                                               | `r-base`                                            | R-devel added side-by-side onto r-base (using alias `RD`)  | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel.svg)                                                                            |
| [`rocker/drd`](base/r-devel.md)                                                   | `r-base`                                            | Lighter `rocker/r-devel`                                   | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drd.svg)                                                                                |
| [`rocker/drp`](base/r-devel.md)                                                   | `r-base`                                            | R-patched added side-by-side onto r-base (using alias `RP`) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drp.svg)                                                                                |
| [`rocker/r-devel-san`](base/r-devel.md)                                           | `r-base`                                            | as `rocker/r-devel`, but built with compiler sanitizers    | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-san.svg)                                                                        |
| [`rocker/r-devel-ubsan-clang`](base/r-devel.md)                                   | `r-base`                                            | Sanitizers, clang c compiler (instead of gcc)              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-ubsan-clang.svg)                                                                |

This stack builds on `debian:testing` and Debian unstable repo.
Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.

`r-base` (Docker Official image) and `rocker/r-base` are built from the same Dockerfile,
but with different build tools.

### Additional images

| image                                  | base image                                                                | description                                                                                                       | pulls                                                                    |
|----------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [`rocker/r-ubuntu`](other/r-ubuntu.md) | `ubuntu`                                                                  | Close to `r-base`, but based on `ubuntu`                                                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-ubuntu.svg) |
| [`rocker/r-bspm`](other/r-bspm.md)     | `r-base`, `rocker/r-ubuntu`, `archlinux`, `fedora`, `opensuse/tumbleweed` | Binary installation of R packages has been configured, powered by [bspm](https://cran.r-project.org/package=bspm) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-bspm.svg)   |
| [`rocker/r2u`](https://eddelbuettel.github.io/r2u)     | `ubuntu`  | [r2u](https://eddelbuettel.github.io/r2u) offers all CRAN packages as binaries for Ubuntu, also uses [bspm](https://cran.r-project.org/package=bspm) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r2u.svg)   |


### Rocker Pre-built Dev Container Images

Images built by [the Dev Container CLI](https://github.com/devcontainers/cli).
See [the Rocker Dev Container Images page](devcontainer/images.md) for details.

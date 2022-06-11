---
title: "The Rocker Images: choosing a container"
---



The rocker project provides a collection of containers suited for different needs. find a base image to extend or images with popular software and optimized libraries pre-installed. Get the latest version or a reproducibly fixed environment.

### The versioned stack

| image                                                               | base image                                  | description                                                                    | pulls                                                                   |
|---------------------------------------------------------------------|---------------------------------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`rocker/r-ver`](https://hub.docker.com/r/rocker/r-ver)             | [`ubuntu`](https://hub.docker.com/_/ubuntu) | Install R from source and set RSPM as default CRAN mirror                      | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-ver)       |
| [`rocker/rstudio`](https://hub.docker.com/r/rocker/rstudio)         | `rocker/r-ver`                              | Adds RStudio Server                                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/rstudio)     |
| [`rocker/tidyverse`](https://hub.docker.com/r/rocker/tidyverse)     | `rocker/rstudio`                            | Adds tidyverse packages & devtools                                             | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/tidyverse)   |
| [`rocker/verse`](https://hub.docker.com/r/rocker/verse)             | `rocker/tidyverse`                          | Adds tex & publishing-related package                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/verse)       |
| [`rocker/geospatial`](https://hub.docker.com/r/rocker/geospatial)   | `rocker/verse`                              | Adds geospatial packages                                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/geospatial)  |
| [`rocker/binder`](https://hub.docker.com/r/rocker/binder)           | `rocker/geospatial`                         | Adds requirements to run repositories on [mybinder.org](https://mybinder.org/) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/binder)      |
| [`rocker/shiny`](https://hub.docker.com/r/rocker/shiny)             | `rocker/r-ver`                              | Adds shiny server                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny)       |
| [`rocker/shiny-verse`](https://hub.docker.com/r/rocker/shiny-verse) | `rocker/shiny`                              | Adds tidyverse packages                                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/shiny-verse) |
| [`rocker/cuda`](https://hub.docker.com/r/rocker/cuda)               | `rocker/r-ver`                              | Adds CUDA support to `rocker/r-ver`                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/cuda)        |
| [`rocker/ml`](https://hub.docker.com/r/rocker/ml)                   | `rocker/cuda`                               | Adds CUDA support to `rocker/tidyverse`                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/ml)          |
| [`rocker/ml-verse`](https://hub.docker.com/r/rocker/ml-verse)       | `rocker/ml`                                 | Adds CUDA support to `rocker/geospatial`                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/ml-verse)    |

This stack builds on stable Debian releases (for versions <= `3.6.3`) or Ubuntu LTS (for versions >= `4.0.0`). Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:3.4.0` for R `3.4.0`.  Version-tagged images are designed to be stable, consistently providing the same versions of all software (R, R packages, system libraries) rather than the latest available (though Debian system libraries will still recieve any security patches.)  Omit the tag or specify `:latest` to always recieve the latest (nightly build) versions, or `:devel` for an image running on the current development (pre-release) version of R.  This is a linear stack, with each image extending the previous one.

See [the rocker-versioned2 repository](https://github.com/rocker-org/rocker-versioned2) for details.

### The base stack

| image                                                                                                     | base image                                          | description                                                | pulls                                                                                                                      |
|-----------------------------------------------------------------------------------------------------------|-----------------------------------------------------|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| [`r-base`](https://hub.docker.com/_/r-base), [`rocker/r-base`](https://hub.docker.com/r/rocker/r-base) | [`debian:testing`](https://hub.docker.com/_/debian) | Install current R from unstable repos                      | ![Docker Pulls](https://img.shields.io/docker/pulls/library/r-base.svg)  ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-base.svg) |
| [`rocker/r-devel`](https://hub.docker.com/r/rocker/r-devel)                                               | `r-base`                                            | R-devel added side-by-side onto r-base (using alias `RD`)  | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel.svg)                                                                |
| [`rocker/drd`](https://hub.docker.com/r/rocker/drd)                                                       | `r-base`                                            | Lighter `rocker/r-devel`                                   | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drd.svg)                                                                    |
| [`rocker/drp`](https://hub.docker.com/r/rocker/drp)                                                       | `r-base`                                            | R-pached added side-by-side onto r-base (using alias `RP`) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/drp.svg)                                                                    |
| [`rocker/r-devel-san`](https://hub.docker.com/r/rocker/r-devel-san)                                       | `r-base`                                            | as `rocker/r-devel`, but built with compiler sanitizers    | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-san.svg)                                                            |
| [`rocker/r-devel-ubsan-clang`](https://hub.docker.com/r/rocker/r-devel-ubsan-clang)                       | `r-base`                                            | Sanitizers, clang c compiler (instead of gcc)              | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-devel-ubsan-clang.svg)                                                    |

This stack builds on `debian:testing` and `debian:unstable`.  This is a branched stack, with all other images extending `r-base`.  Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.

See [the rocker repository](https://github.com/rocker-org/rocker) for details.

### Additional images

| image                                                         | base image                                                                | description                                                                                                       | pulls                                                        |
|---------------------------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| [`rocker/r-ubuntu`](https://hub.docker.com/r/rocker/r-ubuntu) | `ubuntu`                                                                  | Close to `r-base`, but based on `ubuntu`                                                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-ubuntu.svg) |
| [`rocker/r-bspm`](https://hub.docker.com/r/rocker/r-bspm)     | `r-base`, `rocker/r-ubuntu`, `archlinux`, `fedora`, `opensuse/tumbleweed` | Binary installation of R packages has been configured, powered by [bspm](https://cran.r-project.org/package=bspm) | ![Docker Pulls](https://img.shields.io/docker/pulls/rocker/r-bspm.svg)   |

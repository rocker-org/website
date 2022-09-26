---
title: Other projects
---

Here are some images and tools that serve a similar purpose to the Rocker images.
Please refer to the links for more information.

## Docker images for R

### [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

The stack of Docker images by [Project Jupyter](https://jupyter.org/),
based on Ubuntu, install packages from [conda-forge](https://conda-forge.org/),
and configured to run Jupyter.

It includes several images with the R package already installed,
such as [`jupyter/r-notebook`](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-r-notebook)
and [`jupyter/datascience-notebook`](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-datascience-notebook),
so you can immediately run R on Jupyter.

### [b-data/jupyterlab-r-docker-stack](https://github.com/b-data/jupyterlab-r-docker-stack)

Multi-arch (`linux/amd64`, `linux/arm64/v8`) docker images:

* [`registry.gitlab.b-data.ch/jupyterlab/r/base`](https://gitlab.b-data.ch/jupyterlab/r/base/container_registry)  
  * [`registry.gitlab.b-data.ch/jupyterlab/r/r-ver`](https://gitlab.b-data.ch/jupyterlab/r/r-ver/container_registry) (4.0.4 ≤ version < 4.2.0)
* [`registry.gitlab.b-data.ch/jupyterlab/r/tidyverse`](https://gitlab.b-data.ch/jupyterlab/r/tidyverse/container_registry)  
* [`registry.gitlab.b-data.ch/jupyterlab/r/verse`](https://gitlab.b-data.ch/jupyterlab/r/verse/container_registry)  
* [`registry.gitlab.b-data.ch/jupyterlab/r/geospatial`](https://gitlab.b-data.ch/jupyterlab/r/geospatial/container_registry)  

Images considered stable for R versions ≥ 4.2.0. Differences to
[The Rocker versioned stack](../index.md) and the
[Jupyter Docker Stacks](#jupyter-docker-stacks):

1. Multi-arch: `linux/amd64`, `linux/arm64/v8`  
   → Since R v4.0.4 (2021-02-15)
1. Base image: [Debian](https://hub.docker.com/_/debian) instead of
   [Ubuntu](https://hub.docker.com/_/ubuntu)
1. IDE: [code-server](https://github.com/coder/code-server) instead of
   [RStudio](https://github.com/rstudio/rstudio)
1. Just Python – no [Conda](https://github.com/conda/conda) /
   [Mamba](https://github.com/mamba-org/mamba)

### [r-hub/r-minimal](https://github.com/r-hub/r-minimal)

Very small size image with R installed on [alpine](https://hub.docker.com/_/alpine).

### [RStudio R Docker Images](https://github.com/rstudio/r-docker)

Images of RStudio built and installed R binaries.

### [Docker containers for Bioconductor](https://bioconductor.org/help/docker/)

[Bioconductor](https://bioconductor.org/) docker images with system dependencies to install all packages.
Based on [`rocker/rstudio`](versioned/rstudio.md).

### [rhub-linux-builders](https://github.com/r-hub/rhub-linux-builders)

Docker configuration for the Linux builders of [the R-hub package builder](https://builder.r-hub.io/advanced).
These images are useful for you to run to debug your R package.

### [runiverse/base](https://github.com/r-universe-org/base-image)

A docker image for building R source packages and documentation,
used in the [R-universe](https://r-universe.dev) build tool.

## Other tools

### [Mamba](https://github.com/mamba-org/mamba)

A package manager to install various packages from [conda-forge](https://conda-forge.org/) and others.

If you use Mamba on Linux for R, it may be easier to install packages,
see also the [Extending images](../use/extending.md#conda-forge) page.

### [rig](https://github.com/r-lib/rig)

An R Installation Manager (Previously known as rim).

With rig, you can easily install and switch between specific versions of R.

### [rsi](https://github.com/b-data/rsi)

Intended for system administrators who want to perform a source-installation of
R.

It is meant for installing
[official releases of R source code](https://cran.r-project.org/src/base/)
on Debian-based Linux distributions, e.g. Ubuntu, using a docker container.

### [gsi](https://github.com/b-data/gsi)

Intended for system administrators who want to perform a source-installation of
[Git](https://github.com/git/git).

It is meant for installing
[tagged Git releases](https://github.com/git/git/tags) on Debian-based Linux
distributions, e.g. Ubuntu, using a docker container.

### [glfsi](https://github.com/b-data/glfsi)

Intended for system administrators who want to perform an installation of Git
LFS on any Linux distribution using a docker container.

### [ghc4pandoc](https://github.com/benz0li/ghc4pandoc)

The multi-arch (`linux/amd64`, `linux/arm64/v8`) docker image used to build the
Linux amd64 and arm64 binary
[releases of pandoc](https://github.com/jgm/pandoc/releases).

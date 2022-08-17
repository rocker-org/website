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
used in the [R-universe](https://r-universe.dev) build system.

## Other tools

### [Mamba](https://github.com/mamba-org/mamba)

A package manager to install various packages from [conda-forge](https://conda-forge.org/) and others.

If you use Mamba on Linux for R, it may be easier to install packages,
see also the [Extending images](../use/extending.md#conda-forge) page.

### [rig](https://github.com/r-lib/rig)

An R Installation Manager (Previously known as rim).

With rig, you can easily install and switch between specific versions of R.

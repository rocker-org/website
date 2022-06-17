---
title: cuda, ml, ml-verse
---

## Quick reference

- Source repository: [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2)
- Dockerfile
  - [rocker/cuda](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/cuda_devel.Dockerfile)
  - [rocker/ml](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/ml_devel.Dockerfile)
  - [rocker/ml-verse](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/ml-verse_devel.Dockerfile)
- tags
  - rocker/cuda
    - [DockerHub](https://hub.docker.com/r/rocker/cuda/tags)
    - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/cuda/versions)
  - rocker/ml
    - [DockerHub](https://hub.docker.com/r/rocker/ml/tags)
    - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/ml/versions)
  - rocker/ml-verse
    - [DockerHub](https://hub.docker.com/r/rocker/ml-verse/tags)
    - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/ml-verse/versions)
- Published image details: [rocker-org/rocker-versioned2's wiki](https://github.com/rocker-org/rocker-versioned2/wiki)
- Non-root default user:
  - rocker/cuda: not exist
  - rocker/ml: `rstudio`
  - rocker/ml-verse: `rstudio`

## Overview

`rocker/cuda`, `rocker/ml`, and `rocker/ml-verse` are Docker images for machine learning and GPU-based computation in R.
These images correspond to [`rocker/r-ver`](r-ver.md),
[`rocker/tidyverse`, and `rocker/geospatial`](rstudio.md), respectively.

All images are based on the current Ubuntu LTS and based on the official [NVIDIA CUDA docker build recipes](https://gitlab.com/nvidia/container-images/cuda/).

:::{.callout-note}

Older images, `rocker/ml-gpu`, `rocker/tensorflow` and `rocker/tensorflow-gpu`, built with cuda 9.0, are deprecated and no longer supported.

:::

## Quick start

The basic usage is the same as [`rocker/r-ver`](r-ver.md) or [`rocker/rstudio`](rstudio.md) except for the GPU setting.

R command line:

```bash
# CPU-only
docker run --rm -ti rocker/cuda
# Machines with nvidia-docker and GPU support
docker run --gpus all --rm -ti rocker/cuda
```

RStudio Server instance:

```bash
# CPU-only
docker run -p 8787:8787 rocker/ml
# Machines with nvidia-docker and GPU support
docker run --gpus all -p 8787:8787 rocker/ml
```

:::{.callout-important}

GPU use requires [nvidia-docker](https://github.com/NVIDIA/nvidia-docker/) runtime to run!

:::

## Python versions and virtualenvs

The ML images configure a default python virtualenv using the Ubuntu system python (3.8.5 for current Ubuntu 20.04 LTS), see [install_python.sh](https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_python.sh).  This virtualenv is user-writable and the default detected by `reticulate` (using `WORKON_HOME` and `PYTHON_VENV_PATH` variables).

Images also configure [pipenv](https://github.com/pypa/pipenv) with [pyenv](https://github.com/pyenv/pyenv) by default.  This makes it very easy to manage projects that require specific versions of Python as well as specific python modules.  For instance, a project using the popular [`greta`](https://greta-stats.org/) package for GPU-accelerated Bayesian inference needs Tensorflow 1.x, which requires Python <= 3.7, might do:

```bash
pipenv --python 3.7
```

In the bash terminal to set up a pipenv-managed virtualenv in the working directory using Python 3.7.  Then in R we can activate this virtualenv

```r
venv <- system("pipenv --venv", inter = TRUE)
reticulate::use_virtualenv(venv, required = TRUE)
```

We can now install tensorflow version needed, e.g.

```r
install.packages("tensorflow")
tensorflow::install_tensorflow(version="1.14.0-gpu", extra_packages="tensorflow-probability==0.7.0")
```

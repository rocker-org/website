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

All images are based on the official [NVIDIA CUDA docker build recipes](https://gitlab.com/nvidia/container-images/cuda/),
and are installed [the `reticulate` package](https://rstudio.github.io/reticulate/).

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

## How to use

See also [the `rocker/r-ver`'s reference](r-ver.md) (for `rocker/cuda`) and
[the `rocker/rstudio`'s reference](rstudio.md) (for `rocker/ml` and `rocker/ml-verse`).

### Python versions and environments

If you want to switch the Python version called from `reticulate`,
you can use [the `reticulate`'s functions](https://rstudio.github.io/reticulate/reference/index.html) to install Python.
For example, with the following command, `reticulate` installs [miniconda](https://docs.conda.io/en/latest/miniconda.html)
and miniconda installs Python 3.7.

```r
reticulate::install_miniconda()
reticulate::conda_install(packages = "python=3.7")
```

The Python version used by the `reticulate` package can be checked with the `reticulate::py_config()` function.

```r
reticulate::py_config()
#> python:         /root/.local/share/r-miniconda/envs/r-reticulate/bin/python
#> libpython:      /root/.local/share/r-miniconda/envs/r-reticulate/lib/libpython3.7m.so
#> pythonhome:     /root/.local/share/r-miniconda/envs/r-reticulate:/root/.local/share/r-miniconda/envs/r-reticulate
#> version:        3.7.12 | packaged by conda-forge | (default, Oct 26 2021, 06:08:21)  [GCC 9.4.0]
#> numpy:          /root/.local/share/r-miniconda/envs/r-reticulate/lib/python3.7/site-packages/numpy
#> numpy_version:  1.17.5
```

:::{.callout-important}

[pyenv](https://github.com/pyenv/pyenv) and [pipenv](https://github.com/pypa/pipenv),
which were previously installed, are no longer installed.
And, the previously set environment variables `WORKON_HOME` and `PYTHON_VENV_PATH` are no longer set.
([rocker-org/rocker-versioned2#494](https://github.com/rocker-org/rocker-versioned2/pull/494))

:::

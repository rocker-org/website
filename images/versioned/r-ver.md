---
title: r-ver
aliases:
  - /use/blas/
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
- Set [the Posit Public Package Manager (P3M, a.k.a RStudio Package Manager, RSPM)](https://packagemanager.rstudio.com)
  as default CRAN mirror.
  For the amd64 platform, RSPM serves compiled Linux binaries of R packages and greatly speeds up package installs.
- Non-latest R version images installs all R packages from a fixed snapshot of CRAN mirror at a given date.
  This setting ensures that the same version of the R package is installed no matter when the installation is performed.
- Provides images that are generally smaller than the `r-base` series.

:::{.callout-note}

This document is for R 4.0.0 >= images.
Please check the [rocker-org/rocker-versioned](https://github.com/rocker-org/rocker-versioned) repository for R <= 3.6.3 images.

:::

## Special tags

### `devel`

The `devel` images are based on `ubuntu:latest` (the latest Ubuntu LTS version) and install [the latest R-devel daily snapshot](https://cloud.r-project.org/src/base-prerelease/).

### `cuda`

Tags which contain `cuda` (e.g. `rocker/r-ver:4.0.0-cuda10.1`) are alias of [`rocker/cuda`](cuda.md).

:::{.callout-warning}

cuda tags will be discontinued in the future, so please use `rocker/cuda` instead.

:::

## How to use

### Switch the default CRAN mirror

As explained in the overview, `rocker/r-ver` may have set a past CRAN snapshot as the default repository.
This is determined by the options set in the `Rprofile`.
To use a different CRAN mirror, simply write a new setting in the `Rprofile`.

For example, the following Dockerfile sets the default repository to CRAN.

```{.dockerfile filename="Dockerfile"}
FROM rocker/r-ver:4
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >>"${R_HOME}/etc/Rprofile.site"
```

:::{.callout-tip}

To do the same thing by a non-root user in a container, for example, the following command can be used.

```{.bash filename="Terminal"}
echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' | sudo sh -c 'cat - >>"${R_HOME}/etc/Rprofile.site"'
```

:::

:::{.callout-tip}

We can also use the script [`setup_R.sh`](https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/setup_R.sh)
included in `rocker/r-ver`.

```{.dockerfile filename="Dockerfile"}
FROM rocker/r-ver:4
RUN /rocker_scripts/setup_R.sh https://packagemanager.rstudio.com/cran/__linux__/jammy/2023-01-29
```

The advantage of using this script is that if you specify a URL
for binary installation from Posit Public Package Manager (P3M),
it will rewrite the URL and switch to source installation on non-amd64 platforms.

For example, in the above example,
`https://packagemanager.rstudio.com/cran/__linux__/jammy/2023-01-29`
is set for the amd64 platform,
but `https://packagemanager.rstudio.com/cran/2023-01-29` is set
for the arm64 platform as the default CRAN mirror.

:::

Or, if you want to temporarily change the CRAN mirror during an R session, use the `options()` function.

A common use case is when developing an R package and using the `devtools::check()` function;
if the CRAN mirror is not changed from the default, an error like
`cannot open URL 'packagemanager.posit.co/cran/__linux__/jammy/latest/web/packages/packages.rds': HTTP status was '404 Not Found'`
may occur.

```{.r filename="R Terminal"}
options(repos = c(CRAN = "https://cloud.r-project.org"))
devtools::check()
```

It is also possible to set up P3M and CRAN at the same time
to achieve both binary installation and successful the `devtools::check()` function as follows.
([rocker-org/rocker-versioned2#658](https://github.com/rocker-org/rocker-versioned2/issues/658))

```{.dockerfile filename="Dockerfile"}
FROM rocker/r-ver:4
RUN echo 'options(repos = c(P3M = "https://packagemanager.posit.co/cran/__linux__/jammy/latest", CRAN = "https://cloud.r-project.org"))' >>"${R_HOME}/etc/Rprofile.site"
```

### Selecting the BLAS implementation used by R

By default `rocker/r-ver` uses [the OpenBLAS](https://www.openblas.net/) implementation for Linear Algebra[^blas].
But it is possible to switch for [the reference BLAS implementation](https://www.netlib.org/blas/)
(as provided by the Debian package `libblas-dev`) using the Shared BLAS setup[^shared-blas].

[^blas]: [R Installation and Administration A.3.1 BLAS](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#BLAS)
[^shared-blas]: [R Installation and Administration A.3.1.4 Shared BLAS](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS)

:::{.callout-important}

Calling Python `numpy` by the `reticulate` package on R using OpenBLAS may cause a segfault.
This causes an error when trying to use Python packages like `matplotlib` or `scikit-learn`.
([rocker-org/rocker-versioned2#471](https://github.com/rocker-org/rocker-versioned2/issues/471),
[numpy/numpy#21643](https://github.com/numpy/numpy/issues/21643))

If this error occurs, change the BLAS used by R to libblas as described below.

:::

#### Checking which BLAS is in use

You can see the current BLAS configuration for R by using `sessionInfo()` function in R console.

```{.r filename="R Terminal"}
sessionInfo()
#> R version 4.2.0 (2022-04-22)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
#> LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
```

Here for instance R uses OpenBLAS.

#### Switching BLAS implementations

You can switch BLAS used by R with the Debian `update-alternatives` script:

:::{.panel-tabset}

##### Switch to libblas

```{.bash filename="Terminal"}
ARCH=$(uname -m)
update-alternatives --set "libblas.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/blas/libblas.so.3"
update-alternatives --set "liblapack.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/lapack/liblapack.so.3"
```

##### Switch to openblas

```{.bash filename="Terminal"}
ARCH=$(uname -m)
update-alternatives --set "libblas.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/openblas-pthread/libblas.so.3"
update-alternatives --set "liblapack.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/openblas-pthread/liblapack.so.3"
```

:::

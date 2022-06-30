---
title: "Extending images"
description: Install your favorite packages on the containers.
aliases:
  - /use/extending/
---

If there are libraries needed on the container, it is recommended to write a Dockerfile and build the image.

See [the Dockerfile reference](https://docs.docker.com/engine/reference/builder/) and
[the Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
for to write Dockerfiles.
Also, please refer to [the reference page of each Rocker image](../images/index.md)
for links to the respective Dockerfile of Rocker image.

This section covers several topics specific to the installation of R packages into Docker containers.

:::{.callout-note}

Users can also preserve changes to Docker images that they have modified interactively
using [the `docker commit` mechanism.](https://docs.docker.com/engine/reference/commandline/commit/)

While this is sometimes convenient, we encourage users to consider writing Dockerfiles instead whenever possible,
as this creates a more transparent and reproducible mechanism to accomplish the same thing.

:::

## Install R packages on Linux

### Install source packages

When installing R packages from [CRAN](https://cran.r-project.org/) (the official package repository for R) on Linux,
source installation is performed. This differs from Windows and macOS.

Source installation may require system libraries needed to build the package.

As an example, here is a Dockerfile that installs [the `curl` package](https://CRAN.R-project.org/package=curl)
from source on [`r-base`](https://hub.docker.com/_/r-base), which has already set up to install R packages from
[the 0-Cloud CRAN mirror](https://cloud.r-project.org/) (Automatic redirection to servers worldwide).

```dockerfile
FROM r-base:latest
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && R -q -e 'install.packages("curl")'
```

Before installing the `curl` package, you must install `libcurl4-openssl-dev` (libcurl) by using `apt-get`.
If you try to source install the `curl` package without libcurl, the installation will fail because it cannot be built.

In general, system requirements can be found on error messages on installation failures, the package's reference page,
CRAN, or [METACRAN](https://www.r-pkg.org/).
[The dashboard of system libraries linked by R packages on R-universe](https://r-universe.dev/sysdeps/) is useful as well.

### Install binary packages

Source installations generally take longer than binary installations,
so there are several ways to install binary R packages on Linux.

#### [RStudio Public Package Manager](https://packagemanager.rstudio.com/)

RStudio Package Manager (RSPM) provides binary R packages for specific Linux distributions[^rspm].
Since RSPM provides all packages on CRAN as a CRAN mirror,
users can install packages just as if they were installed from CRAN.

[^rspm]: [RStudio Package Manager: Admin Guide](https://docs.rstudio.com/rspm/admin/serving-binaries/#supported-operating-systems)

For example, Ubuntu based image [`rocker/r-ver:4`](../images/versioned/r-ver.md) on amd64 platform,
which has already set up the public version of RSPM (RStudio Public Package Manager) as its default CRAN mirror,
can install the `curl` package as follows.

```dockerfile
FROM rocker/r-ver:4
RUN R -q -e 'install.packages("curl")'
```

:::{.callout-important}

Some packages (e.g. [`sf`](https://CRAN.R-project.org/package=sf))
will fail to load if the system requirements are not met when the package is attempted to be loaded.
In such cases, the system libraries must be installed as in the case of source installation.

Please check [frequently asked questions for RStudio Public Package Manager](https://support.rstudio.com/hc/en-us/articles/360046703913).

:::

:::{.callout-note}

Binary installation from RSPM only supports amd64 now.
So, R package installation on `rocker/r-ver` on arm64 platform will be source installation.

:::

:::{.callout-tip}

Binary-installed packages from RSPM are not stripped and may be larger in size.
([rocker-org/rocker-versioned2#340](https://github.com/rocker-org/rocker-versioned2/issues/340))

Therefore, it may be possible to reduce the image size by stripping immediately after R package installation as follows.

```dockerfile
FROM rocker/r-ver:4
RUN R -q -e 'install.packages("curl")' \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
```

:::

#### System package management system

Some Linux distributions allow installation of binary R packages with the system package management system.

- [Debian](https://cran.r-project.org/bin/linux/debian/)
- [Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/)
- [Fedora/RHEL](https://cran.r-project.org/bin/linux/fedora/)
- [openSUSE](https://cran.r-project.org/bin/linux/suse/README.html)

Since `r-base` and [`rocker/r-ubuntu`](../images/other/r-ubuntu.md) are already configured to enable them,
you can install R packages with the `apt-get install` command like this.

```dockerfile
FROM r-base:latest
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    r-cran-curl \
    && rm -rf /var/lib/apt/lists/*
```

:::{.callout-important}

This method can only be used if R is installed with the System Package Manager.

Do not use this method for [`rocker/r-ver` or its derivative images](../images/index.md#the-versioned-stack)
as they have installed R from source.

:::

:::{.callout-note}

Not all packages available in CRAN are available.

:::

#### [bspm](https://github.com/Enchufa2/bspm)

bspm provides functions to manage R packages via the distribution's package manager from R.

For example, [`rocker/r-bsmp:testing`](../images/other/r-bspm.md) (based on `r-base`)
can install `r-cran-curl` with the `install.packages()` R function.

```dockerfile
FROM rocker/r-bspm:testing
RUN R -q -e 'install.packages("curl")' \
    && rm -rf /var/lib/apt/lists/*
```

#### [conda-forge](https://conda-forge.org/)

If you use the [`conda`](https://github.com/conda/conda) command
(or the [`mamba`](https://github.com/mamba-org/mamba) command) to install R,
you can install the many binary R package from conda-forge.

Currently, the Rocker project has no `mamba` (or `conda`) based Docker images.
So, use [`jupyter/base-notebook`](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-base-notebook)
maintained by [the Project Jupyter](https://jupyter.org/) for example.

```dockerfile
FROM jupyter/base-notebook:latest
RUN mamba install -y r-curl \
    && mamba clean -yaf
```

:::{.callout-note}

Package versions may differ due to CPU architecture (amd64 and arm64).
Please chack package pages on conda-forge for details.

:::

## Helper commands

Rocker images provide a few utility functions to streamline this process,
including the [`littler`](https://cran.r-project.org/package=littler) scripts
which provide a concise syntax for installing packages in Dockerfiles.

### `install2.r`

[The `install2.r` command](https://github.com/eddelbuettel/littler/blob/master/inst/examples/install2.r)
can be used to concisely describe the installation of the R package.

For example, a Dockerfile that installs multiple R packages can be written as follows.

```dockerfile
FROM r-base:latest
RUN install2.r pkg1 pgk2 pkg3
```

If the same content were written using the `install.packages()` function,
it would be more complicated, as shown below.

```dockerfile
FROM r-base:latest
RUN R -q -e 'install.packages(c("pkg1", "pkg2", "pkg3"))'
```

If you install R packages from CRAN using the `install2.r` command,
the temporary files are stored in `/tmp/downloaded_packages` directory.
Therefore, it is recommended to delete `/tmp/downloaded_packages` at the end if you use this command in Dockerfiles.

```dockerfile
FROM r-base:latest
RUN install2.r pkg1 pgk2 pkg3 \
    && rm -rf /tmp/downloaded_packages
```

#### Options

The `install2.r` command also has several useful options.

##### `-e`, `--error`

By setting the `--error` option, you can make the `docker build` command also fail if the package installation fails.

##### `-s`, `--skipinstalled`

`--skipinstalled` option to skip installing installed packages.

##### `-n`, `--ncpus`

You can set `--ncpu -1` to maximize parallelism of the installation.

##### `-r`, `--repos`

You can install R packages from specific repositories with this option.
A special value `--repos getOption` means using R's `getOption("repos")` value.

#### Examples

Use with `r-base`; Install source R packages from CRAN.

```dockerfile
FROM r-base:latest
RUN install2.r --error --skipinstalled --ncpus -1 \
    pkg1 \
    pgk2 \
    pkg3 \
    && rm -rf /tmp/downloaded_packages
```

Use with `rocker/r-ver`; Install binary R packages from RSPM.

```dockerfile
FROM rocker/r-ver:4
RUN install2.r --error --skipinstalled --ncpus -1 \
    pkg1 \
    pgk2 \
    pkg3 \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
```

Use with `rocker/r-ver`;
Install binary R packages from RSPM and source R packages from the R-universe ropensci repository.

```dockerfile
FROM rocker/r-ver:4
RUN install2.r --error --skipinstalled --ncpus -1 \
    --repos https://ropensci.r-universe.dev --repos getOption \
    pkg1 \
    pgk2 \
    pkg3 \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
```

Use with `rocker/r-bspm`; Install binary R packages from system package repository.

```dockerfile
FROM rocker/r-bspm:testing
RUN install2.r --error --skipinstalled \
    pkg1 \
    pgk2 \
    pkg3 \
    && rm -rf /var/lib/apt/lists/*
```

:::{.callout-note}

If bspm is already set,
some options have no effect because the system package manager is used to install the R packages.

:::

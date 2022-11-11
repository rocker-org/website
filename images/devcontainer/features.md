---
title: Dev Container Features
---

## Overview

The Rocker Project provides some Dev Container Features for installing R or installing software often used with R.

These can be used to easily configure R on containers without R installed,
or to make containers for R even more useful.
And of course, we can use them independently of R! (except for the Features to install R)

```{.json filename=".devcontainer/devcontainer.json"}
{
    "image": "mcr.microsoft.com/devcontainers/universal:2",
    "features": {
        "ghcr.io/rocker-org/devcontainer-features/r-apt:latest": {}
    }
}
```

## Install R on Dev Containers

1. [`r-apt`](https://github.com/rocker-org/devcontainer-features/tree/main/src/r-apt)
2. [`r-rig`](https://github.com/rocker-org/devcontainer-features/tree/main/src/r-rig)
3. [`miniforge`](https://github.com/rocker-org/devcontainer-features/tree/main/src/miniforge)[^miniforge]

[^miniforge]: This Feature does not directly install R, but it configures mamba so we can use mamba to install R.

Each of these installations of R will be configured to allow installation of R binary packages in the following ways.

1. [System package management system](../../use/extending.md#system-package-management-system)
2. [RStudio Public Package Manager](../../use/extending.md#rstudio-public-package-manager)[^rspm]
3. [conda-forge](../../use/extending.md#conda-forge)

[^rspm]: Of the amd64 and arm64 Debian and Ubuntu platforms that can use `r-rig`,
only amd64 Ubuntu can use RSPM, and RSPM is not configured on the other platforms.

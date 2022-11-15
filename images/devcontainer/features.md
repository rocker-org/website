---
title: Dev Container Features
---

## Overview

The Rocker Project provides some [Dev Container Features](https://containers.dev/implementors/features/)
for installing R or installing software often used with R.

- Source repository: [rocker-org/devcontainer-features](https://github.com/rocker-org/devcontainer-features)

You can find them on the [Dev Containers site](https://containers.dev/collections),
[the GitHub Codespaces Dev Container Editor](https://github.blog/changelog/2022-10-21-codespaces-configuration-with-the-dev-container-editor/),
or, [VSCode Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).

These can be used to easily configure R on containers without R installed,
or to make containers for R even more useful.
And of course, we can use them independently of R! (except for the Features to install R)

For example, install R on the default image of Codespaces
by editing [the `devcontainer.json` file](https://containers.dev/implementors/spec/#devcontainerjson) as follows:

```{.json filename=".devcontainer/devcontainer.json"}
{
    "image": "mcr.microsoft.com/devcontainers/universal:2",
    "features": {
        "ghcr.io/rocker-org/devcontainer-features/r-apt:latest": {}
    }
}
```

Check the source repository for details on each Feature.

## Install R on Dev Containers

1. [`r-apt`](https://github.com/rocker-org/devcontainer-features/tree/main/src/r-apt)
2. [`r-rig`](https://github.com/rocker-org/devcontainer-features/tree/main/src/r-rig)
3. [`miniforge`](https://github.com/rocker-org/devcontainer-features/tree/main/src/miniforge)[^miniforge]

[^miniforge]: This Feature does not directly install R, but it configures mamba so we can use mamba to install R.

Each of these installations of R will be configured to allow installation of R binary packages in the following ways.

1. [System package management system (`apt`)](../../use/extending.md#system-package-management-system)
2. [RStudio Public Package Manager (R functions e.g. `install.packages`)](../../use/extending.md#rstudio-public-package-manager)[^rspm]
3. [conda-forge (`mamba` or `conda`)](../../use/extending.md#conda-forge)

[^rspm]: Of the amd64 and arm64 Debian and Ubuntu platforms that can use `r-rig`,
only amd64 Ubuntu can use RSPM, and RSPM is not configured on the other platforms.

Therefore, which of these you use to install R
may depend on which method you wish to use to install the R binary packages.

Some tips for choosing:

- When installing R packages via `apt` or `mamba` (`conda`), dependencies are installed automatically.
  But, installing R packages via R function (`install.packages`)
  may require separate `apt` installations of system libraries that are dependencies.
- Generally `r-apt` installs R packages faster than `r-rig`.
  Therefore, if you want to add R to a container, we recommend trying `r-apt` first.
  However, `r-apt` does not support `ubuntu` on arm64 platform, so if you want to use `ubuntu` on arm64 platform,
  use `r-rig` instead.
- If you want to install any version of R or use R already installed in the container,
  you can use `r-rig` to install any version of R or only the R package without installing R.
- If you want to install packages that exist in the conda-forge,
  you can use `miniforge` for fast installation with `mamba`.

## See also

- [Dev Container Images](images.md)
- [Dev Container Templates](templates.md)

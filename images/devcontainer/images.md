---
title: Rocker Pre-built Dev Container Images
---

## Quick reference

- Source repository: [rocker-org/devcontainer-images](https://github.com/rocker-org/devcontainer-images)
- Source
  - [r-ver](https://github.com/rocker-org/devcontainer-images/tree/main/src/r-ver)
  - [tidyverse, geospatial](https://github.com/rocker-org/devcontainer-images/tree/main/src/rstudio)
- tags
  - [r-ver](https://github.com/rocker-org/devcontainer-images/pkgs/container/devcontainer%2Fr-ver)
  - [tidyverse](https://github.com/rocker-org/devcontainer-images/pkgs/container/devcontainer%2Ftidyverse)
  - [geospatial](https://github.com/rocker-org/devcontainer-images/pkgs/container/devcontainer%2Fgeospatial)
- Published image details: [rocker-org/devcontainer-images's wiki](https://github.com/rocker-org/devcontainer-images/wiki)
- Non-root default user: `rstudio`

## Overview

The Rocker Project provides some Docker container images which built with Dev Container Features.
Packages commonly used for development are already installed.

These images are intended to be images for R that can be used like the Dev Container images
built from [`devcontainers/images`](https://github.com/devcontainers/images) for each language.

`ghcr.io/rocker-org/devcontainer/r-ver`, `ghcr.io/rocker-org/devcontainer/tidyverse`,
and `ghcr.io/rocker-org/devcontainer/geospatial` are correspond to [`rocker/r-ver`](../versioned/r-ver.md),
[`rocker/tidyverse`, and `rocker/geospatial`](../versioned/rstudio.md), respectively.

## How to use

### devcontainer.json and Dockerfile

Specify the image in [`devcontainer.json`](https://containers.dev/implementors/spec/#devcontainerjson) as follows.

```{.json filename=".devcontainer/devcontainer.json"}
{
    "name": "${localWorkspaceFolderBasename}",
    "image": "ghcr.io/rocker-org/devcontainer/r-ver:4"
}
```

The basic usage is to customize by adding [Dev Container Features](https://containers.dev/features) here.

Or, we can use it as a base image in a Dockerfile.

```{.dockerfile filename=".devcontainer/Dockerfile"}
FROM ghcr.io/rocker-org/devcontainer/tidyverse:4
```

To install the R package on the Dockerfile, please refer to [the Extending images page](../../use/extending.md).

When using a combination of a `devcontainer.json` and a Dockerfile,
the `devcontainer.json` file must be rewritten to refer to the Dockerfile.

```{.json filename=".devcontainer/devcontainer.json"}
{
    "name": "${localWorkspaceFolderBasename}",
    "build": {
        "dockerfile": "Dockerfile"
    }
}
```

### Command line

We can use [radian](https://github.com/randy3k/radian) instead of the default R console.

```{.sh filename="Terminal"}
docker run --rm -ti ghcr.io/rocker-org/devcontainer/r-ver:4 radian
```

Also [`httpgd`](https://nx10.github.io/httpgd/) is already installed
so we can expose the container port to show the plot in the browser.
See [the GUI page](../../use/gui.md) for details.

### RStudio Server

`ghcr.io/rocker-org/devcontainer/tidyverse` and `ghcr.io/rocker-org/devcontainer/geospatial`
have already installed RStudio Server.
See [the `rocker/rstudio` reference page](../versioned/rstudio.md) for usage.

## See also

- [Rocker Dev Container Features](features.md)
- [Rocker Dev Container Templates](templates.md)

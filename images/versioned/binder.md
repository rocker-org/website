---
title: binder
---

## Quick reference

- Source repository: [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2)
- [Dockerfile](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/binder_devel.Dockerfile)
- tags
  - [DockerHub](https://hub.docker.com/r/rocker/binder/tags)
  - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/binder/versions)
- Published image details: [rocker-org/rocker-versioned2's wiki](https://github.com/rocker-org/rocker-versioned2/wiki)
- Non-root default user: `rstudio`

## Overview

This image is based on [`rocker/geospatial`](rstudio.md) and
configured to run RStudio Server on [Binder](https://mybinder.org/),
thanks to [`jupyter-rsession-proxy`](https://github.com/jupyterhub/jupyter-rsession-proxy).

For instructions on how to use this image with Binder for your project,
see the [rocker-org/binder](https://github.com/rocker-org/binder), a template repository.

By placing the following badge
[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/rocker-org/binder/HEAD?urlpath=rstudio){fig-alt="Binder"}
in `README.md` of your project,
RStudio can be started and used in the browser by simply clicking on the badge.

```md
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/<GITHUB_USER>/<REPO>/<BRANCH>?urlpath=rstudio)
```

You can also make a Binder badge with `usethis::use_binder_badge()` R function.

:::{.callout-note}

This document is for R 4.0.0 >= images.

:::

## How to use

### Use outside of Binder

If you use this image with Docker,
the default command runs [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).
Since the JupyterLab port is set to `8888`,
you can open the JupyterLab screen on `localhost:8888` from your browser with the following command.

```sh
docker run --rm -ti -p 8888:8888 rocker/binder
```

You can log in by entering the token displayed in the terminal as your password.

If you want to set your own password for Jupyter, you can set it as a environment variable `JUPYTER_TOKEN`[^jupyter].

[^jupyter]: [Jupyter Server Config file and command line options](https://jupyter-server.readthedocs.io/en/stable/full-config.html)

```sh
docker run --rm -ti -e JUPYTER_TOKEN=yourpassword -p 8888:8888 rocker/binder
```

:::{.callout-tip}

RStudio Server started from Jupyter does not read environment variables set at container startup;
if you want to use environment variables on your RStudio instance, set them on the `.Renviron` file.

:::

To run RStudio Server directly as in [`rocker/rstudio`](rstudio.md),
execute `/init` command with the root user specified.

```sh
docker run --rm -ti -p 8787:8787 --user root rocker/binder /init
```

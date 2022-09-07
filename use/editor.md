---
title: Edit in containers
description: Edit R code in the containers.
---

To edit source code in a container, an editor must be installed in the container.
This section presents several R integrated development environments that can be used within containers.

See also: [GUI](gui.md)

## RStudio IDE

[RStudio IDE](https://www.rstudio.com/products/rstudio/) is the most popular IDE for R.

To use RStudio IDE on a container,
[RStudio Server](https://www.rstudio.com/products/rstudio/download-server/) should be installed in the container.

There are images [`rocker/rstudio` etc.](../images/versioned/rstudio.md) with RStudio Server installed,
which can be used to immediately run RStudio Server.

```sh
docker run --rm -ti -p 8787:8787 rocker/rstudio:4
```

For more information on how to use these images, please check the image reference pages.

:::{.callout-tip}

Looking for Docker images for RStudio professional products?
Check out the [rstudio/rstudio-docker-products](https://github.com/rstudio/rstudio-docker-products) repository.

:::

## Jupyter

[Jupyter](https://jupyter.org/) is a web-based IDE
that allows you to run Python and other programming languages interactively like notebook.

To use R on Jupyter,
install [the `IRkernel` R package](https://irkernel.github.io/) in addition to installing Jupyter itself.

[`rocker/binder`](../images/versioned/binder.md) has already installed these and starts Jupyter Notebook by default.

```sh
docker run --rm -ti -p 8888:8888 rocker/binder:4
```

There are also Docker images with many R packages installed maintained by Project Jupyter,
e.g. [`jupyter/r-notebook`](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-r-notebook).

```sh
docker run --rm -ti -p 8888:8888 jupyter/r-notebook:latest
```

## VSCode

[Visual Studio Code - Open Source (Code - OSS)](https://github.com/microsoft/vscode) is
currently one of the most popular editors.

When editing R in VSCode, [vscode-R](https://github.com/REditorSupport/vscode-R) is a popular extension.
This extension is recommended to be used with
[`languageserver`](https://github.com/REditorSupport/languageserver) and [`httpgd`](https://nx10.github.io/httpgd/).

### Visual Studio Code Remote - Containers

The Microsoft's Code OSS distribution, [Visual Studio Code](https://code.visualstudio.com/),
has an extension, [Remote - Containers](https://code.visualstudio.com/docs/remote/containers).
That makes a container the backend, which can be used to develop using software in the container.

The Remote - Containers extension builds images from definition files
and creates containers with installed VSCode Server and vscode extensions.
Users can run the container and start working inside it without touching anything but the local VSCode.

The Remote - Containers extension also includes ready-to-use sample definition files.
The R's definition is [this](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/r),
which installs `languageserver` and `httpgd`,
and also installs [`radian`](https://github.com/randy3k/radian) as R console.

This definition can also be used in [GitHub Codespaces](https://github.com/features/codespaces).

### coder/code-server and  gitpod-io/openvscode-server

Both [coder's code-server](https://github.com/coder/code-server) and [gitpod's openvscode-server](https://github.com/gitpod-io/openvscode-server)
can run VSCode server-side and use VSCode from a browser.
They can also be installed and used inside Docker containers.

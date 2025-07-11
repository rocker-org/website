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

### Visual Studio Code Dev Containers

The Microsoft's Code OSS distribution, [Visual Studio Code](https://code.visualstudio.com/),
has an extension, [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).
(Formerly known as "Remote - Containers".)

That makes a container the backend, which can be used to develop using software in the container.

The Dev Containers extension builds images from definition files
and creates containers with installed VSCode Server and vscode extensions.
Users can run the container and start working inside it without touching anything but the local VSCode.

The Dev Containers extension can load and use templates published on the web.
The R's definition is [this](https://github.com/rocker-org/devcontainer-templates/tree/main/src/r-ver),
which installs `languageserver` and `httpgd`,
and also installs [`radian`](https://github.com/randy3k/radian) as R console.

This definition can also be used in [GitHub Codespaces](https://github.com/features/codespaces).

See also

- [Dev Container Templates](../images/devcontainer/templates.md)
- [Dev Container Images](../images/devcontainer/images.md)
- [Dev Container Features](../images/devcontainer/features.md)

### Positron

[Positron](https://positron.posit.co/) is an IDE for data science based on
Code OSS, which has deep integration with R.
Positron does not have an extension like Visual Studio Code's Dev Containers extension,
so it cannot control Dev Containers from Positron, and it requires to use
[Remote SSH](https://positron.posit.co/remote-ssh.html) to connect to the container.

The easiest way to connect to a container with Positron is to create a Dev Container
with [DevPod](https://devpod.sh/), which has Positron support and automatically
creates the container and connects to it from Positron.

See also

- [Dev Container Templates](../images/devcontainer/templates.md)
- [Dev Container Images](../images/devcontainer/images.md)
- [Dev Container Features](../images/devcontainer/features.md)

### coder/code-server and gitpod-io/openvscode-server

Both [coder's code-server](https://github.com/coder/code-server) and
[gitpod's openvscode-server](https://github.com/gitpod-io/openvscode-server)
can run Code - OSS server-side and you can use it from the browser.
To use them in a Docker container, they must be installed in the container.

---
title: GUI
description: View plots etc. from the containers.
---

If you do not use a web-based IDE (like [RStudio Server, Jupyter, VSCode](editor.md), etc.) with integrated graphics devices,
the following additional configuration is required to display plots of R running in your container.

## The `httpgd` R package

[`httpgd`](https://nx10.github.io/httpgd/index.html) is a graphics device for R that is accessible via HTTP.

Start the httpgd server in the container that published a port,
and you can access the plot viewer in your browser.

```sh
docker run --rm -ti -p 8000:8000 <imagename> R
```

:::{.callout-note}

Since the `httpgd` package is not installed in the Rocker project images,
you will need to build your own image with `httpgd` installed
(or, install `httpgd` in your container).

:::

For details,
please check [the `httpgd`'s vignette for Docker](https://nx10.github.io/httpgd/articles/b03_docker.html).

## X11

:::{.callout-important}

While this approach is generic, it is often difficult to configure or perform well,
especially on non-Linux operating systems.

:::

X11 forwarding by connecting the X11 server in the container to the X11 client on the local machine.

Commands vary depending on the situation, but for example,
the commands like below are used.

```sh
docker run --rm -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix <imagename> R
```

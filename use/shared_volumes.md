---
title: Shared Volumes
description: Use docker volumes and bind mounts to save files.
aliases:
  - /use/shared_volumes/
---

[Docker volumes](https://docs.docker.com/storage/volumes/) and [bind mounts](https://docs.docker.com/storage/bind-mounts/) are
mechanisms for persisting data generated by and used by Docker containers.

These are widely used, but bind mounts, which mounts files and directories on the host machine on the container,
are prone to problems due to Linux file system permissions and should be used with caution.

## Bind mounts

When a Linux file system is bind-mounted to a Linux container,
the UID and GID of the user who owns the file will match both inside and outside the container.

Generally, the UID is matched by creating a user in the container with the same UID as the host machine
and specifying that user in the `docker run`'s `--user` option to enter the container.

A default (UID 1000) user has already been created for many of the Rocker images.
Check the image reference page for more information.

For example, `r-base`'s default user is named `docker`.

```sh
docker run --rm -ti --user docker r-base bash
```

If a user with UID 1000 wants to bind-mount the "work" directory in the current directory to r-base and work on it,
they can use the following command to work in the container and not worry about the permission being overwritten.

```sh
docker run --rm -ti --user docker -v "$(pwd)"/work:/workspace r-base bash
```

:::{.callout-important}

`rocker/rstudio` etc. requires the root user to execute the `/init` command to start RStudio Server.
So, do not set the `--user` option if you want to use RStudio Server.

Instead, the UID and GID of the default user for logging into RStudio
can be changed at container start by specifying environment variables.
Please check [the reference page](../images/versioned/rstudio.md#userid-and-groupid).

:::

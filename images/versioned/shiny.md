---
title: shiny, shiny-verse
---

## Quick reference

- Source repository: [rocker-org/rocker-versioned2](https://github.com/rocker-org/rocker-versioned2)
- Dockerfile
  - [rocker/shiny](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/shiny_devel.Dockerfile)
  - [rocker/shiny-verse](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/shiny-verse_devel.Dockerfile)
- tags
  - rocker/shiny
    - [DockerHub](https://hub.docker.com/r/rocker/shiny/tags)
    - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/shiny/versions)
  - rocker/shiny-verse
    - [DockerHub](https://hub.docker.com/r/rocker/shiny-verse/tags)
    - [GitHub Container Registry](https://github.com/rocker-org/rocker-versioned2/pkgs/container/shiny-verse/versions)
- Published image details: [rocker-org/rocker-versioned2's wiki](https://github.com/rocker-org/rocker-versioned2/wiki)
- Non-root default user: not exist

## Overview

These images are based on [`rocker/r-ver`](r-ver.md),
and [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/) is already installed.

The basic usage of these images is the same, with the difference being the amount of additional (R) packages installed.
(See [image details](https://github.com/rocker-org/rocker-versioned2/wiki) for lists of installation packages)

- `rocker/shiny-verse` has already installed [the tidyverse package](https://www.tidyverse.org/),
  some [R Database Interface](https://dbi.r-dbi.org/) packages,
  [the `data.table` package](https://rdatatable.gitlab.io/data.table/), [the `fst` package](https://www.fstpackage.org/),
  and [the Apache Arrow R package](https://arrow.apache.org/docs/r/).

Since the Shiny Server port is set to `3838`,
you can open the Shiny screen on `localhost:3838` from your browser with the following command.

```sh
docker run --rm -ti -p 3838:3838 rocker/shiny
```

:::{.callout-note}

This document is for R 4.0.0 >= images. For R <= 3.6 images,
please check the [rocker-org/shiny](https://github.com/rocker-org/shiny) repository.

:::

## How to use

### Environment variables

Several special environment variables can be set to modify Shiny Server's behavior.

#### `APPLICATION_LOGS_TO_STDOUT`

The Shiny Server log and all application logs are written to stdout and can be viewed using the `docker logs` command.

The logs for individual apps are still kept in the `/var/log/shiny-server` directory[^shiny_server_logs].
If you want to avoid printing the logs to stdout,
set the environment variable `APPLICATION_LOGS_TO_STDOUT` to `false`.

[^shiny_server_logs]: [Shiny Server Administrator's Guide](https://docs.rstudio.com/shiny-server/#application-error-logs)

```sh
docker run --rm -ti -e APPLICATION_LOGS_TO_STDOUT=false -p 3838:3838 rocker/shiny
```

### Run by non-root user

Shiny Server is normally run by the `root` user,
and sessions within the Shiny Server use the non-root user with UID 999 named `shiny`.

By setting the `--user` option as follows, Shiny Server can be run by the `shiny` user.

```sh
docker run --rm -ti --user shiny -p 3838:3838 rocker/shiny
```

### See also

- [Managing Users](../../use/managing_users.md)
- [Shared Volumes](../../use/shared_volumes.md)
- [Networking](../../use/networking.md)

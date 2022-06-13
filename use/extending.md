---
title: "Extending images"
description: Install your favorite packages on the containers.
aliases:
  - /use/extending/
---

Rocker images provide a few utility functions to streamline this process, including the 
[littler](https://cran.r-project.org/package=littler) scripts which provide a concise syntax for installing packages in Dockerfiles, e.g.

```Dockerfile
RUN install2.r pkg1 pgk2 pkg3 ...
```

By setting the `--error` option, you can make the `docker build` command also fail if the package installation fails.
And, you can also set the `--skipinstalled` option to skip installing installed packages and the `--ncpu -1` option
to maximize parallelism of the installation.

```Dockerfile
RUN install2.r --error --skipinstalled --ncpus -1 \
    pkg1 \
    pgk2 \
    pkg3 \
    ...
```

Users writing their own Dockerfiles are encouraged to follow the same practices as the
Rocker Project, such as the [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/), the use of automated builds,
and when appropriate, versioned tags.

Note that users can also preserve changes to Rocker images that they have modified interactively using
the `docker commit` mechanism, which creates a new binary image which can be pushed back to
a personal account on the Docker Hub.  While this is sometimes convenient, we encourage users to
consider writing Dockerfiles instead whenever possible, as this creates a more transparent
and reproducible mechanism to accomplish the same thing.

Users should understand how the Dockerfile on which Rocker images are built works before writing new
Dockerfiles that extend the images we provide. See [here](https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/r-ver_devel.Dockerfile) for the source code that defines the `rocker/r-ver` image that many Rocker images are based on.

An example is changing the default `repos` used by the container. This could be changed back to CRAN
repos by adding the following line to an appropriate place in your Dockerfile:

```Dockerfile
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> ${R_HOME}/etc/Rprofile.site
```

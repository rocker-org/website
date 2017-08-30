---
title: "The Rocker Project"
description: "Docker Containers for the R Environment"
type: "page"
layout: "profile"
markup: "mmark"
---


## <i class="fa fa-rocket"></i> Getting Started ##

Ensure you have [Docker installed](https://docs.docker.com/installation/) and start R inside a container with: 

```
docker run --rm -ti rocker/r-base
```

Or get started with an RStudio® instance:

```
docker run -p 8787:8787 rocker/rstudio
```

and point your browser to `localhost:8787`.  Log in with user/password `rstudio/rstudio`.


## Choosing a rocker container

The rocker project provides a collection of containers suited for different needs. find a base image to extend or images with popular software and optimized libraries pre-installed. Get the latest version or a reproducibly fixed environment.

### The rocker-versioned stack


`rocker/r-ver`, `rocker/rstudio`, `rocker/tidyverse`, `rocker/verse`, `rocker/geospatial`. 

This stack builds on stable Debian releases (`debian:8` for versions < `3.4.1`, `debian:9` after). Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:3.4.0` for R `3.4.0`.  Version-tagged images are designed to be stable, consistently providing the same versions of all software (R, R packages, system libraries) rather than the latest available (though Debian system libraries will still recieve any security patches.)  Omit the tag or specify `:latest` to always recieve the latest (nightly build) versions, or `:devel` for an image running on the current development (pre-release) version of R.  This is a linear stack, with each image extending the previous one.  

### The rocker base stack

`r-base`, `rocker/drd`, `rocker/devel-san`

This stack builds on `debian:testing` and `debian:unstable`.  This is a branched stack, with all other images extending `r-base`.  Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.



## Working with containers

- Accessing local files: shared volumes
- Managing users & permissions
- Networking: tips and tricks
  - https and monitoring via `caddy` & `netdata`
  - linking database containers
- Extending images
  - Versioned stack
- Misc topics
  - X11


## <i class="fa fa-balance-scale"></i> License ##

The Dockerfiles in this repository are licensed under the GPL 2 or later.

##  <i class="fa fa-trademark"></i> Trademarks ##

RStudio® is a registered trademark of RStudio, Inc.  The use of the trademarked term RStudio® and the distribution of the RStudio binaries through the images hosted on [hub.docker.com](https://registry.hub.docker.com/) has been granted by explicit permission of RStudio Inc.  Please review [RStudio's trademark use policy](http://www.rstudio.com/about/trademark/) and address inquiries about further distribution or other questions to [permissions@rstudio.com](emailto:permissions@rstudio.com).



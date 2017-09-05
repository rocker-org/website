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
docker run --rm -p 8787:8787 rocker/rstudio
```

and point your browser to `localhost:8787`.  Log in with user/password `rstudio/rstudio`.  




## <i class="fa fa-balance-scale"></i> License ##

The Rocker Dockerfiles are licensed under the GPL 2 or later.

##  <i class="fa fa-trademark"></i> Trademarks ##

RStudio® is a registered trademark of RStudio, Inc.  The use of the trademarked term RStudio® and the distribution of the RStudio binaries through the images hosted on [hub.docker.com](https://registry.hub.docker.com/) has been granted by explicit permission of RStudio Inc.  Please review [RStudio's trademark use policy](http://www.rstudio.com/about/trademark/) and address inquiries about further distribution or other questions to [permissions@rstudio.com](emailto:permissions@rstudio.com).



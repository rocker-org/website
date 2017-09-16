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

For more information and further options, see the [use](/use) page.

&nbsp;
<div class="section">
<h2> <i class="material-icons">people</i> Team </h2>
<div class = "row">
<div class="col-md-4 col-md-offset-2">
<a href="https://twitter.com/cboettig"><img class="img-circle img-raised img-responsive center-block" src="/img/cboettig.jpg"/></a>
</div>
<div class="col-md-4">
<a href="https://twitter.com/eddelbuettel"><img class="img-circle img-raised img-responsive center-block" src="/img/edd.jpg"/></a>
</div>
</div>
<br/>

The Rocker project is maintained by Carl Boettiger and Dirk Eddelbuettel with significant contributions from a broad community of users and developers. Get in touch on [GitHub issues](https://github.com/rocker-org/rocker/issues) with bug reports, feature requests, or other feedback. 

</div>



## <i class="fa fa-balance-scale"></i> License ##

The Rocker Dockerfiles are licensed under the GPL 2 or later.

##  <i class="fa fa-trademark"></i> Trademarks ##

RStudio® is a registered trademark of RStudio, Inc.  The use of the trademarked term RStudio® and the distribution of the RStudio binaries through the images hosted on [hub.docker.com](https://registry.hub.docker.com/) has been granted by explicit permission of RStudio Inc.  Please review [RStudio's trademark use policy](http://www.rstudio.com/about/trademark/) and address inquiries about further distribution or other questions to [permissions@rstudio.com](emailto:permissions@rstudio.com).



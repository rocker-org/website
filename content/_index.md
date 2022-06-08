---
title: "The Rocker Project"
description: "Docker Containers for the R Environment"
layout: "landing-page"
markup: "mmark"
---


## <i class="fa fa-rocket"></i> Getting Started ##

Ensure you have [Docker installed](https://docs.docker.com/installation/) and start R inside a container with:

```
docker run --rm -ti rocker/r-base
```

Or get started with an RStudio® instance:

```
docker run -e PASSWORD=yourpassword --rm -p 8787:8787 rocker/rstudio
```

and point your browser to `localhost:8787`.  Log in with user/password `rstudio`/`yourpassword`.
**If a password is not provided, a randomly generated password will be given in the docker log for the container**.  Check the terminal output or use `docker logs` command to check.  

For more information and further options, see the [use](/use) page.

&nbsp;
<h2> <i class="material-icons">people</i> Team </h2>
<div class = "row">
<div class="col-md-4">
<a href="https://twitter.com/cboettig"><img class="img-circle img-raised img-responsive center-block" src="/img/cboettig.jpg"/></a>
</div>
<div class="col-md-4">
<a href="https://twitter.com/eddelbuettel"><img class="img-circle img-raised img-responsive center-block" src="/img/edd.jpg"/></a>
</div>
<div class="col-md-4">
<a href="https://twitter.com/noamross"><img class="img-circle img-raised img-responsive center-block" src="/img/noamross.jpg"/></a>
</div>
</div>

The Rocker project was created by <a href="https://twitter.com/cboettig">Carl Boettiger</a> and <a href="https://twitter.com/eddelbuettel">Dirk Eddelbuettel</a>, and is now maintained by Carl, Dirk, <a href="https://twitter.com/noamross">Noam Ross</a>, and <a href="https://twitter.com/eitsupi">SHIMA Tatsuya</a>, with significant contributions from a broad community of users and developers. Get in touch on [GitHub issues](https://github.com/rocker-org/rocker/issues) with bug reports, feature requests, or other feedback.


## <i class="fa fa-balance-scale"></i> License ##

The Rocker Dockerfiles are licensed under the GPL 2 or later.

## <i class="fa fa-handshake-o"></i> Support ##

We are grateful for support from the <a href="https://chanzuckerberg.com/">Chan-Zuckerberg Initiative</a>'s Essential Open Source Software for Science Program.

 <a href="https://chanzuckerberg.com/"><img style="max-width:100px;" class="img-responsive center-block" src="/img/czi-logo.png"/></a>

##  <i class="fa fa-trademark"></i> Trademarks ##

RStudio® is a registered trademark of RStudio, Inc.  The use of the trademarked term RStudio® and the distribution of the RStudio binaries through the images hosted on [hub.docker.com](https://registry.hub.docker.com/) has been granted by explicit permission of RStudio Inc.  Please review [RStudio's trademark use policy](http://www.rstudio.com/about/trademark/) and address inquiries about further distribution or other questions to [permissions@rstudio.com](emailto:permissions@rstudio.com).



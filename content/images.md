---
title: "The Rocker Images: choosing a container"
---



The rocker project provides a collection of containers suited for different needs. find a base image to extend or images with popular software and optimized libraries pre-installed. Get the latest version or a reproducibly fixed environment.

### The versioned stack


<table class="table table-condensed table-striped">
<thead>
<tr>
<th>image</th>
<th>description</th>
<th>size</th>
<th>metrics</th>
<th>build status</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/rocker/r-ver">r-ver</a></td>
<td>Specify R version in docker tag. Builds on <code>debian:stable</code></td>
<td><a href="https://microbadger.com/images/rocker/r-ver"><img src="https://images.microbadger.com/badges/image/rocker/r-ver.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-ver"><img src="https://img.shields.io/docker/pulls/rocker/r-ver.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-ver/builds"><img src="https://img.shields.io/docker/automated/rocker/r-ver.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/rstudio">rstudio</a></td>
<td>Adds rstudio</td>
<td><a href="https://microbadger.com/"><img src="https://images.microbadger.com/badges/image/rocker/rstudio-stable.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/rstudio"><img src="https://img.shields.io/docker/pulls/rocker/rstudio.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/rstudio/builds"><img src="https://img.shields.io/docker/automated/rocker/rstudio.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/tidyverse">tidyverse</a></td>
<td>Adds tidyverse &amp; devtools</td>
<td><a href="https://microbadger.com/images/rocker/tidyverse"><img src="https://images.microbadger.com/badges/image/rocker/tidyverse.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/tidyverse"><img src="https://img.shields.io/docker/pulls/rocker/tidyverse.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/tidyverse/builds"><img src="https://img.shields.io/docker/automated/rocker/tidyverse.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/verse">verse</a></td>
<td>Adds tex &amp; publishing-related packages</td>
<td><a href="https://microbadger.com/images/rocker/verse"><img src="https://images.microbadger.com/badges/image/rocker/verse.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/verse"><img src="https://img.shields.io/docker/pulls/rocker/verse.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/verse/builds"><img src="https://img.shields.io/docker/automated/rocker/verse.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/geospatial">geospatial</a></td>
<td>Adds geospatial libraries</td>
<td><a href="https://microbadger.com/images/rocker/geospatial"><img src="https://images.microbadger.com/badges/image/rocker/geospatial.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/geospatial"><img src="https://img.shields.io/docker/pulls/rocker/geospatial.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/geospatial/builds"><img src="https://img.shields.io/docker/automated/rocker/geospatial.svg" alt="" /></a></td>
</tr>
</tbody>
</table>




This stack builds on stable Debian releases (`debian:8` for versions < `3.4.1`, `debian:9` after). Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:3.4.0` for R `3.4.0`.  Version-tagged images are designed to be stable, consistently providing the same versions of all software (R, R packages, system libraries) rather than the latest available (though Debian system libraries will still recieve any security patches.)  Omit the tag or specify `:latest` to always recieve the latest (nightly build) versions, or `:devel` for an image running on the current development (pre-release) version of R.  This is a linear stack, with each image extending the previous one.  

### The base stack

<table class="table table-condensed table-striped">
<thead>
<tr>
<th>image</th>
<th>description</th>
<th>size</th>
<th>metrics</th>
<th>build status</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/_/r-base">r-base</a></td>
<td>Current R via apt-get with <code>debian:testing</code> &amp; <code>unstable</code> repos</td>
<td><a href="https://microbadger.com/images/library/r-base"><img src="https://images.microbadger.com/badges/image/library/r-base.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/library/r-base"><img src="https://img.shields.io/docker/pulls/library/r-base.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/library/r-base/builds"><img src="https://img.shields.io/docker/automated/rocker/r-base.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel">r-devel</a></td>
<td>R-devel added side-by-side onto r-base (using alias <code>RD</code>)</td>
<td><a href="https://microbadger.com/images/rocker/r-devel"><img src="https://images.microbadger.com/badges/image/rocker/r-devel.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel"><img src="https://img.shields.io/docker/pulls/rocker/r-devel.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel/builds"><img src="https://img.shields.io/docker/automated/rocker/r-devel.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/drd">drd</a></td>
<td>lighter r-devel, built not quite daily</td>
<td><a href="https://microbadger.com/images/rocker/drd"><img src="https://images.microbadger.com/badges/image/rocker/drd.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/drd"><img src="https://img.shields.io/docker/pulls/rocker/drd.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/drd/builds"><img src="https://img.shields.io/docker/automated/rocker/drd.svg" alt="" /></a></td>
</tr>
</tbody>
</table>


This stack builds on `debian:testing` and `debian:unstable`.  This is a branched stack, with all other images extending `r-base`.  Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.

### Additional images 





<table  class="table table-condensed table-striped">
<thead>
<tr>
<th>image</th>
<th>description</th>
<th>size</th>
<th>metrics</th>
<th>build status</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san">r-devel-san</a></td>
<td>as r-devel, but built with compiler sanatizers</td>
<td><a href="https://microbadger.com/images/rocker/r-devel-san"><img src="https://images.microbadger.com/badges/image/rocker/r-devel-san.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san"><img src="https://img.shields.io/docker/pulls/rocker/r-devel-san.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san/builds"><img src="https://img.shields.io/docker/automated/rocker/r-devel-san.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel-ubsan-clang">r-devel-ubsan-clan</a></td>
<td>Sanatizers, clang c compiler (instead of gcc)</td>
<td><a href="https://microbadger.com/images/rocker/r-devel-ubsan-clang"><img src="https://images.microbadger.com/badges/image/rocker/r-devel-ubsan-clang.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-ubsan-clang"><img src="https://img.shields.io/docker/pulls/rocker/r-devel-ubsan-clang.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-ubsan-clang/builds"><img src="https://img.shields.io/docker/automated/rocker/r-devel-ubsan-clang.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san">rstudio:testing</a></td>
<td>rstudio on debian:testing</td>
<td><a href="https://microbadger.com/images/rocker/r-devel-san"><img src="https://images.microbadger.com/badges/image/rocker/r-devel-san.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san"><img src="https://img.shields.io/docker/pulls/rocker/r-devel-san.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san/builds"><img src="https://img.shields.io/docker/automated/rocker/r-devel-san.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/shiny">shiny</a></td>
<td>shiny-server on r-base</td>
<td><a href="https://microbadger.com/images/rocker/shiny"><img src="https://images.microbadger.com/badges/image/rocker/shiny.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/shiny"><img src="https://img.shields.io/docker/pulls/rocker/shiny.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/shiny/builds"><img src="https://img.shields.io/docker/automated/rocker/shiny.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-apt">r-apt</a></td>
<td>(R plus CRAN + marutter repo information)</td>
<td><a href="https://microbadger.com/images/rocker/r-apt"><img src="https://images.microbadger.com/badges/image/rocker/r-apt.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-apt"><img src="https://img.shields.io/docker/pulls/rocker/r-apt.svg" alt="" /></a></td>
<td><a href="https://hub.docker.com/r/rocker/r-apt/builds"><img src="https://img.shields.io/docker/automated/rocker/r-apt.svg" alt="" /></a></td>
</tr>
</tbody>
</table>


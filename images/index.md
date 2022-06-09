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
<th>metrics</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/rocker/r-ver">r-ver</a></td>
<td>Specify R version in docker tag. Builds on <code>debian:stable</code></td>
<td><a href="https://hub.docker.com/r/rocker/r-ver"><img src="https://img.shields.io/docker/pulls/rocker/r-ver.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/rstudio">rstudio</a></td>
<td>Adds rstudio</td>
<td><a href="https://hub.docker.com/r/rocker/rstudio"><img src="https://img.shields.io/docker/pulls/rocker/rstudio.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/tidyverse">tidyverse</a></td>
<td>Adds tidyverse &amp; devtools</td>
<td><a href="https://hub.docker.com/r/rocker/tidyverse"><img src="https://img.shields.io/docker/pulls/rocker/tidyverse.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/verse">verse</a></td>
<td>Adds tex &amp; publishing-related packages</td>
<td><a href="https://hub.docker.com/r/rocker/verse"><img src="https://img.shields.io/docker/pulls/rocker/verse.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/geospatial">geospatial</a></td>
<td>Adds geospatial libraries</td>
<td><a href="https://hub.docker.com/r/rocker/geospatial"><img src="https://img.shields.io/docker/pulls/rocker/geospatial.svg" alt="" /></a></td>
</tr>
</tbody>
</table>

This stack builds on stable Debian releases (for versions <= `3.6.3`) or Ubuntu LTS (for versions >= `4.0.0`). Images in this stack accept a version tag specifying which version of R is desired, e.g. `rocker/rstudio:3.4.0` for R `3.4.0`.  Version-tagged images are designed to be stable, consistently providing the same versions of all software (R, R packages, system libraries) rather than the latest available (though Debian system libraries will still recieve any security patches.)  Omit the tag or specify `:latest` to always recieve the latest (nightly build) versions, or `:devel` for an image running on the current development (pre-release) version of R.  This is a linear stack, with each image extending the previous one.

See [the rocker-versioned2 repository](https://github.com/rocker-org/rocker-versioned2) for details.

### The base stack

<table class="table table-condensed table-striped">
<thead>
<tr>
<th>image</th>
<th>description</th>
<th>metrics</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/_/r-base">r-base</a></td>
<td>Current R via apt-get with <code>debian:testing</code> &amp; <code>unstable</code> repos</td>
<td><a href="https://hub.docker.com/r/library/r-base"><img src="https://img.shields.io/docker/pulls/library/r-base.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel">r-devel</a></td>
<td>R-devel added side-by-side onto r-base (using alias <code>RD</code>)</td>
<td><a href="https://hub.docker.com/r/rocker/r-devel"><img src="https://img.shields.io/docker/pulls/rocker/r-devel.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/drd">drd</a></td>
<td>lighter r-devel, built not quite daily</td>
<td><a href="https://hub.docker.com/r/rocker/drd"><img src="https://img.shields.io/docker/pulls/rocker/drd.svg" alt="" /></a></td>
</tr>
</tbody>
</table>

This stack builds on `debian:testing` and `debian:unstable`.  This is a branched stack, with all other images extending `r-base`.  Use this stack if you want access to the latest versions of system libraries and compilers through `apt-get`.

See [the rocker repository](https://github.com/rocker-org/rocker) for details.

### Additional images

<table  class="table table-condensed table-striped">
<thead>
<tr>
<th>image</th>
<th>description</th>
<th>metrics</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san">r-devel-san</a></td>
<td>as r-devel, but built with compiler sanitizers</td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-san"><img src="https://img.shields.io/docker/pulls/rocker/r-devel-san.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/r-devel-ubsan-clang">r-devel-ubsan-clan</a></td>
<td>Sanitizers, clang c compiler (instead of gcc)</td>
<td><a href="https://hub.docker.com/r/rocker/r-devel-ubsan-clang"><img src="https://img.shields.io/docker/pulls/rocker/r-devel-ubsan-clang.svg" alt="" /></a></td>
</tr>

<tr>
<td><a href="https://hub.docker.com/r/rocker/shiny">shiny</a></td>
<td>shiny-server on r-ver</td>
<td><a href="https://hub.docker.com/r/rocker/shiny"><img src="https://img.shields.io/docker/pulls/rocker/shiny.svg" alt="" /></a></td>
</tr>

</tbody>
</table>

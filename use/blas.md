---
title: BLAS
description: Setting of blas for Rocker containers.
---

## Selecting the BLAS implementation used by R

By default `rocker/r-ver` uses [the OpenBLAS](https://www.openblas.net/) implementation for Linear Algebra[^blas].
But it is possible to switch for [the reference BLAS implementation](https://www.netlib.org/blas/)
(as provided by the Debian package `libblas-dev`) using the Shared BLAS setup[^shared-blas].

[^blas]: [R Installation and Administration A.3.1 BLAS](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#BLAS)
[^shared-blas]: [R Installation and Administration A.3.1.4 Shared BLAS](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS)

### Checking which BLAS is in use

You can see the current BLAS configuration for R by using `sessionInfo()` function in R console.

```r
sessionInfo()
#> R version 4.2.0 (2022-04-22)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
#> LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
```

Here for instance R uses OpenBLAS.

### Switching BLAS implementations

You can switch BLAS used by R with the Debian `update-alternatives` script:

```bash
export ARCH=$(uname -m)
# switch to libblas
update-alternatives --set "libblas.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/blas/libblas.so.3"
# switch to openblas
update-alternatives --set "libblas.so.3-${ARCH}-linux-gnu" "/usr/lib/${ARCH}-linux-gnu/openblas-pthread/libblas.so.3"
```

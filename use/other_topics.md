---
title: Other topics
---


### selecting the BLAS implementation used by R

By default **rocker/r-ver** uses the OpenBLAS (http://www.openblas.net) implementation for Linear Algebra (cf https://cran.r-project.org/doc/manuals/r-release/R-admin.html#BLAS).
But it is possible to switch for the reference BLAS implementation (http://www.netlib.org/blas/) (as provided by the 
Debian package libblas-dev) using the Shared BLAS setup (cf https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS).

#### checking which BLAS is in use

You can see the current BLAS configuration in your image by using `sessionInfo()` from the R console; e.g.

```r
> sessionInfo()
R version 3.5.0 (2018-04-23)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Debian GNU/Linux 9 (stretch)

Matrix products: default
BLAS: /usr/lib/openblas-base/libblas.so.3
LAPACK: /usr/lib/libopenblasp-r0.2.19.so
```

Here for instance R uses OpenBLAS. 

#### switching BLAS implementations

You can switch from withing the docker container using the Debian `update-alternatives` script:
```
# switch to libblas
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/blas/libblas.so.3
# switch to openBlas
update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
```

You can also pre-select which BLAS to use when running the docker using the `LD_LIBRARY_PATH` environment variable, e.g:
```
# run R with the libblas
docker run -ti -e LD_LIBRARY_PATH=/usr/lib/libblas rocker/r-ver
```

### X11

<div class="alert alert-warning"><div class="container-fluid"><div class="alert-icon">
<i class="material-icons">info_outline</i></div>
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
<span aria-hidden="true"><i class="material-icons">clear</i></span></button>
Coming soon...
</div></div>


## [Singularity](/use/singularity)

See [Singularity](/use/singularity) for use in HPC environments without Docker installed.


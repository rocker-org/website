---
title: Other topics
---


### selecting the BLAS implementation used by R

By default **rocker/r-ver** uses the OpenBLAS (http://www.openblas.net) implementation for Linear Algebra (cf https://cran.r-project.org/doc/manuals/r-release/R-admin.html#BLAS).
But it is possible to switch for the reference BLAS implementation (http://www.netlib.org/blas/) (as provided by the 
Debian package libblas-dev) using the Shared BLAS setup (cf https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS).

#### checking which BLAS is in use

A way of checking which implementation is currently is using the lsof utility, whih first needs to be installed:
`apt-get update && apt-get install lsof`

Then you can check as follows by looking at the name of the BLAS shared library loaded by R:
```
R -q -e "grep('blas', system2('lsof', c('-p', Sys.getpid()), stdout=TRUE), value = TRUE)"
[1] "R       211 root  mem       REG   0,36 32775824    1319 /usr/lib/libopenblasp-r0.2.19.so"
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





---
title: "The Rocker Project"
description: "Docker Containers for the R Environment"
title-block-banner: false
sidebar: false
number-sections: false
about:
  template: jolla
  image: img/rocker.png
  image-shape: rectangle
  image-width: 8em
  links:
    - icon: people-fill
      text: Code of Conduct
      href: CODE_OF_CONDUCT.md
    - icon: github
      text: GitHub
      href: https://github.com/rocker-org
    - text: "{{< fa brands docker >}} Docker Hub"
      href: https://hub.docker.com/u/rocker
format:
  html:
    toc: false
---

## 🚀Getting Started

Ensure you have [Docker installed](https://docs.docker.com/get-started/) and start R inside a container with:

```sh
docker run --rm -ti r-base
```

Or get started with an RStudio® instance:

```sh
docker run --rm -ti -e PASSWORD=yourpassword -p 8787:8787 rocker/rstudio
```

and point your browser to `localhost:8787`. Log in with user/password `rstudio`/`yourpassword`.

For more information and further options, see [the image descriptions](images).

## 👥Team

:::{layout="[30,-5,30,-5,30]" layout-valign="center"}

[![Carl](img/cboettig.jpg)](https://github.com/cboettig)

[![Dirk](img/edd.jpg)](https://github.com/eddelbuettel)

[![Noam](img/noamross.jpg)](https://github.com/noamross)

:::

The Rocker project was created by [Carl Boettiger](https://github.com/cboettig) and [Dirk Eddelbuettel](https://github.com/eddelbuettel),
and is now maintained by Carl, Dirk, [Noam Ross](https://github.com/noamross),
and [SHIMA Tatsuya](https://github.com/eitsupi),
with significant contributions from a broad community of users and developers.
Get in touch on [GitHub issues](https://github.com/rocker-org/rocker/issues) with bug reports,
feature requests, or other feedback.

## 📜Papers

- [An Introduction to Rocker: Docker Containers for R](https://doi.org/10.32614/RJ-2017-065)
- [The Rockerverse: Packages and Applications for Containerisation with R](https://doi.org/10.32614/RJ-2020-007)

## ⚖️License

The Rocker Dockerfiles are licensed under the GPL 2 or later.

## 🤝Support

We are grateful for support from [the Chan-Zuckerberg Initiative](https://chanzuckerberg.com/)'s
Essential Open Source Software for Science Program.

[![](img/czi-logo.png)](https://chanzuckerberg.com/){fig-alt="the Chan-Zuckerberg Initiative"}

## ™️Trademarks

RStudio® is a registered trademark of RStudio, Inc.
The use of the trademarked term RStudio® and the distribution of the RStudio binaries through the images hosted on [Docker Hub](https://registry.hub.docker.com/) has been granted by explicit permission of RStudio Inc.
Please review [RStudio's trademark use policy](http://www.rstudio.com/about/trademark/) and address inquiries about further distribution or other questions to [permissions@rstudio.com](mailto:permissions@rstudio.com).

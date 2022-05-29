---
title: "The Rocker Project"
description: "Docker Containers for the R Environment"
title-block-banner: false
sidebar: false
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
    - text: Docker Hub
      href: https://hub.docker.com/u/rocker
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

For more information and further options, see the use page.

## 👥Team

:::{layout="[30,-5,30,-5,30]" layout-valign="center"}

[![Carl](img/cboettig.jpg)](https://twitter.com/cboettig)

[![Dirk](img/edd.jpg)](https://twitter.com/eddelbuettel)

[![Noam](img/noamross.jpg)](https://twitter.com/noamross)

:::

The Rocker project was created by [Carl Boettiger](https://twitter.com/cboettig) and [Dirk Eddelbuettel](https://twitter.com/eddelbuettel),
and is now maintained by Carl, Dirk, and [Noam Ross](https://twitter.com/noamross),
with significant contributions from a broad community of users and developers.
Get in touch on [GitHub issues](https://github.com/rocker-org/rocker/issues) with bug reports,
feature requests, or other feedback.

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

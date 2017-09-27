---
title: "Extending images"
type: page
---


Rocker images provide a few utility functions to streamline this process, including the 
[littler](https://cran.r-project.org/package=littler) scripts which provide a concise syntax for installing packages in Dockerfiles, e.g.

    RUN install2.r pkg1 pgk2 pkg3 ...


Users writing their own Dockerfiles are encouraged to follow the same practices as the
Rocker Project, such as the [Dockerfile Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/), the use of automated builds,
and when appropriate, versioned tags.  Users can ensure their automated builds are rebuilt
every time the relevant upstream Dockerfile is updated by using build triggers on Docker Hub.

Note that users can also preserve changes to Rocker images that they have modified interactively using
the `docker commit` mechanism, which creates a new binary image which can be pushed back to
a personal account on the Docker Hub.  While this is sometimes convenient, we encourage users to
consider writing Dockerfiles instead whenever possible, as this creates a more transparent
and reproducible mechanism to accomplish the same thing.  





---
title: "Reproducibility"
description: Reproducibility of Rocker Containers.
---

## Tags and digests

Users need to be aware of the meaning of tags when using Docker images repeatedly.

For example, a tag `latest` used by many images (docker automatically complements `latest` if the tag is not specified)
is generally constantly updated to follow the latest version.
The following command will run R 3.6.1 at some point in the past, R 4.2.0 today, and another version of R a year later.

```sh
docker run --rm -ti rocker/r-ver:latest
```

Then, how about the following command then?
Since the tags of [`rocker/r-ver`](../images/versioned/r-ver.md) represents the R version,
this command will always run R 4.2.0.

```sh
docker run --rm -ti rocker/r-ver:4.2.0
```

However, `rocker/r-ver` images are periodically rebuilt,
so software versions other than R are not fixed (they receive security updates through periodic rebuilds).

If you want to always use the exact same image,
you generally need to specify the image with [a digest](https://docs.docker.com/engine/reference/commandline/images/#list-image-digests)
rather than a tag.

```sh
docker run --rm -ti rocker/r-ver@sha256:f32b3e9e353fa63092093f2ce590d819f56eac92f6f79e97906d4f2b0eee5ef3
```

Digests can also be used on Dockerfiles.

```Dockerfile
FROM rocker/r-ver:4.2.0
```

```Dockerfile
FROM rocker/r-ver@sha256:f32b3e9e353fa63092093f2ce590d819f56eac92f6f79e97906d4f2b0eee5ef3
```

:::{.callout-tip}

If a tag and digest are specified at the same time, the digest is used.

```Dockerfile
FROM rocker/r-ver:latest@sha256:f32b3e9e353fa63092093f2ce590d819f56eac92f6f79e97906d4f2b0eee5ef3
```

```Dockerfile
FROM rocker/r-ver:4.2.0@sha256:f32b3e9e353fa63092093f2ce590d819f56eac92f6f79e97906d4f2b0eee5ef3
```

:::

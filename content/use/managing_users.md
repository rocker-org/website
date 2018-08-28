---
title: Managing Users
---

RStudio-based instances now always require a custom password as an environmental variable `-e`:

```bash
docker run -d -p 8787:8787 -e PASSWORD=clever-custom-password rocker/rstudio
```

Without a password, the container will exit with a warning message instead.

In this example, the default user remains `rstudio`, but now has a custom password.  There is generally no need to set a custom user name, even when sharing volumes with the host user.  On Linux-based hosts, sharing volumes requires that the the UID on the container match the UID on the host, otherwise any files edited or created in the container will be owned by `root` instead. Check the user id on the host (`id`) and pass this value to the docker container as an environmental variable, `-e USERID=$UID`, where `$UID` is the local user id.


By default, all rocker containers run as
root. This is consistent with standard Docker practice, allowing both
interactive users and downstream Dockerfiles to install software (with `apt-get`) 
directly without having to switch to root.  The main snag of this approach comes if
a user links a local volume and modifies files on that volume, which will
result in the local file being owned by `root` and not the default user.
To avoid this, specify the non-root user at runtime (username `docker`
on the `r-base` stack, or `rstudio` on images deriving from rstudio)
when running an interactive shell. 


By default, all rocker images run as root.  This means that when running a terminal session such as `R` or `bash`, you will be a root user.  This allows you to easily install additional software on the container with `apt-get` and perform other admin tasks. However, if you are sharing a local volume with the host, any files you create or modify will become owned by `root`.  To avoid this, run interactive terminal sessions with the default user (`docker` for `r-base` containers, `rstudio` for RStudio-derived containers) when sharing volumes with the host, e.g.:

```bash
docker run --rm -ti -v $(pwd):/home/rstudio --user rstudio rocker/verse bash
```

or

```bash
docker run --rm -ti -v $(pwd):/home/docker --user docker r-base 
```

In these examples, we link the current working directory, `$(pwd)`, to a user-owned location on the image, and specify the approriate user name. 

For users accessing R through RStudio, this is not necessary.  The docker container will run as root, but a user logs in through the RStudio server web interface as the non-root user "rstudio", and thus any changes made to linked volumes will not alter file permissions on the home directory.  When running RStudio from a container, do no specify a user with `--user`! The container needs root to launch RStudio.  

In RStudio containers, you can also add the non-root user to the `sudoers` group when the container is launched simply by specifying the environmental variable, `-e ROOT=TRUE` in your `docker run` command.  




  




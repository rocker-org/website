+++
title = "Working with containers"
type = "page"
layout = "sidemenu"
+++

&nbsp;
<div class="tab-pane active" id="shared-volumes">

## Shared Volumes

A common configuration with Rocker containers is to share volumes between the container and the host filesystem.  This allows the container to access and modify local files in directories you specify.  In this way, the container can be treated as ephemeral while files you create will persist after the container is destroyed. Because the container only has access to files within the directories you specify, this can also prevent a user from accidentally modifying unrelated files on the file system when using software inside the container. 

To share a volume with the host we use the `-v` or `--volume` flag. Simply indicate the location on the host machine on the left side of `:`, and indicate the location on the container to the right.  For instance:

```bash
docker run -d -p 8787:8787 -v /Users/bob/Documents:/home/rstudio/Documents rocker/rstudio
```

would link the User `bob`'s Documents directory to the default `rstudio` user's directory on the container.  The above example shows a typical path on a Mac host, which can share any subdirectory under `Users`.  A Linux host can link an arbitrary path.  The same method should work on Windows paths as well, e.g. 

```bash
docker run -d -p 8787:8787 -v /c/Users/foobar:/home/rstudio/foobar rocker/rstudio
```

Would share the host's file `C:/Users/foobar`

### Kitematic


Users of the Docker's GUI interface, [Kitematic](https://kitematic.com), who use the
`rstudio`-derived images will automatically have their local kitematic
directory linked to the `/home/rstudio/kitematic` directory on the
Docker container.  This provides a seamless interface to Docker and the Rocker
images without any need for shell commands. 


</div>

<div class="tab-pane" id="managing-users">

## Managing Users

When using an RStudio-based instance over a public network (e.g. cloud server), remember to launch RStudio with a custom password as an environmental variable `-e`:

```bash
docker run -d -p 8787:8787 -e PASSWORD=clever-custom-password rocker/rstudio
```

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

</div>
<div class="tab-pane" id="networking">

##  Networking: tips and tricks

###  <i class="material-icons">https</i> HTTPS 

Any RStudio instance on a remote server is accessed over an unencrypted http by default (though RStudio encrypts the password entered to log in through client-side javascript.)  The easiest way to connect over a secure https connection is to use a reverse proxy server, such as [Caddy](https://caddyserver.com).  To establish an encrypted https connection, you must first have control of a registered domain name: https cannot be used when connecting directly to a given ip address. Once you have pointed your domain name at the ip address of the server, Caddy provides a quick way to get set up with https using LetsEncrypt certificates.  Below is an example `Caddyfile` specifying the necessary configuration, along with a `docker-compose` file which sets up an RStudio server instance behind a separate container running `caddy`.  This approach also makes it easy to map ports to subdomains for cleaner-looking URLs:

Example `site/Caddyfile`:

```
rstudio.example.com {
  
  tls you@email.com
  proxy / rstudio:8787 {
    header_upstream Host {host}
  }

}

```

Example docker-compose file:

```yml
version: '2'
services:
  caddy:  
    image: joshix/caddy
    links:
      - rstudio
    volumes:
      - ./site/:/var/www/html
      - ./.caddy/:/.caddy
    ports:
      - 80:80
      - 443:443
    restart: always

  rstudio:
    image: rocker/verse 
    env_file: .password 
    volumes:
      - $HOME/students:/home/
    restart: always
```


More details about the use of [docker-compose](https://docs.docker.com/compose/) and [Caddy Server](https://caddyserver.com/) are found on their websites.

### <i class="material-icons">data_usage</i> Monitoring 

### <i class="fa fa-database"></i> Linking database containers

</div>
<div class="tab-pane" id="extending">

## Extending images


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





  
</div>
<div class="tab-pane" id="management">



## Managing containers

The simplest tools to monitor containers are `docker log` and `docker stats` commands.  

### Cleaning up stale instances

Most of the examples shown here include the use of the `--rm` flag, which will cause this container to be removed after it has exited.  By default, a container that is stopped (i.e. exited from) is not removed, and can be resumed later using `docker start`, be saved as a new docker image, or have files copied from it to the host (see the offical Docker documentation).  However, most of the time we just forget about these containers, though they are still taking up disk space.  You can view all stopped as well as running containers by using the `-a` flag to `docker ps`:

```
docker ps -a
```

and can remove all stopped containers by passing the id listed to `docker rm`.  A shortcut to remove all stopped containers (but not any actively running ones) is:

```
docker rm -v $(docker ps -a -q)
```

This avoids filling up your filesystem with stale containers.  This can be particularly useful if you often run containers without the `--rm` flag, such as when running RStudio containers in the background ("detached" mode, `docker run -d`).

### Persistent containers

Often a user might want a container to stay up and restart itself after stopping (such as when docker is upgraded on the host machine, or the host machine is restarted.)  This is most common when working with a container accessed through RStudio.

Use `--restart=always` to have a container restart


### Accessing a running container

Sometimes we need to access a container that is already up and running in the background, such as to install additional libraries.  Some like to think of this as `ssh`-ing into their container, but there is no need to add `ssh` to accomplish this.  Access a running container using the `docker exec` command, e.g.

```
docker exec -ti <container-id> bash
```

will drop us into a bash shell as the root user.

</div>
<div class="tab-pane" id="other">

## Other topics

<div class="alert alert-warning"><div class="container-fluid"><div class="alert-icon">
<i class="material-icons">info_outline</i></div>
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
<span aria-hidden="true"><i class="material-icons">clear</i></span></button>
Coming soon...
</div></div>

- X11

## RStudio connectivity

</div>


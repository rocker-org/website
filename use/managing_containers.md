---
title: Managing containers
aliases:
  - /use/managing_containers/
---

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

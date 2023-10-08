---
title: "Running Rootless"
description: Rootless containers and rocker
execute:
  eval: false
---

Docker traditionally ran as the `root` user. Users who wanted to run docker
containers needed to be given `sudo` access and use `sudo docker`, or be added
to the `docker` group, so they could run docker without typing `sudo` first. In
both cases, they were running docker with root privileges. This is considered a
bad security practice, because it effectively grants root
host privileges to all docker users. However, namespaces and control groups where
not as mature as they are now, and no better alternative
was available.

However today docker offers the possibility to
run in [rootless](https://docs.docker.com/engine/security/rootless/) mode.
[Podman](https://podman.io/) runs rootless by design.

:::{.callout-note appearance="simple"}

## Podman or Docker?

 Podman 4.7 and above includes an extended syntax for `--uidmap` and `--gidmap` that
 makes it straightforward to map additional groups. This feature was 
 [contributed](https://github.com/containers/podman/pull/18713)
 by a rocker user, so you are encouraged to try it!
:::


Running a container rootless does not mean that the container does not have
any root-like capabilities, it means that the container engine does not run
as root. **For most rocker-related projects, running rootless is a security advantage.**


## Who am I?

At the host:

```{.sh}
whoami
# sergio
```

In the container:


```{.sh}
podman run --rm docker.io/rocker/rstudio whoami
# root
```

## Using apt-get inside a rootless container

It is perfectly possible to run `apt-get` commands on a
rootless container, because it just modifies files inside the container.

At the host:

```{.sh}
apt-get update
# Reading package lists... Done
# E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
```

In the container:

```{.sh}
podman run --rm docker.io/rocker/rstudio apt-get update
# Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
# ...
# Fetched 26.8 MB in 6s (4,750 kB/s)
# Reading package lists...
```

## Modifying files

You can bind mount the `/etc/` directory (e.g. using `-v /etc:/hostetc`) but you won't
be able to modify most of its files, since you are not allowed to do that
when you are outside the container.

At the host:

```{.sh}
touch /etc/try-creating-a-file
# touch: cannot touch '/etc/try-creating-a-file': Permission denied
```

In the container: *Rootless means no additional host permissions*

```{.sh}
podman run --rm -v /etc/:/hostetc docker.io/rocker/rstudio \
  touch /hostetc/try-creating-a-file
# touch: cannot touch '/hostetc/try-creating-a-file': Permission denied
```

However, you can modify the files *within* the container:

```{.sh}
podman run --rm docker.io/rocker/rstudio touch /etc/try-creating-a-file
```

And files from mounted volumes, assuming you have the permissions where they
are mounted at the host:

```{.sh}
podman run \
    --rm \
    --volume "$HOME/workdir:/workdir" \
    docker.io/rocker/rstudio touch /workdir/try-creating-a-file
ls "$HOME/workdir/try-creating-a-file"
rm "$HOME/workdir/try-creating-a-file"
```

Your user in the host is mapped to the `root` user in the container.

## Port binding

You can't bind your container to host ports lower than 1024,
since those are reserved to root (or to be precise reserved to processes with
`CAP_NET_BIND_SERVICE` capability set).


```{.sh}
podman run --rm -p 80:8787 docker.io/rocker/rstudio
# Error: rootlessport cannot expose privileged port 80, you can add 
# 'net.ipv4.ip_unprivileged_port_start=80' to /etc/sysctl.conf (currently 1024),
# or choose a larger port number (>= 1024):
# listen tcp 0.0.0.0:80: bind: permission denied
```

However larger port numbers work perfectly fine:

```{.sh}
podman run --rm -p 8787:8787 docker.io/rocker/rstudio
```

## Mounting shared data from an additional group

You may want to mount a directory from a group you belong to, to be able to read
and write into it. Let's say you are `ana` and you belong to the `rfriends`
group in the host. That group has access to the `/shared_data` folder, that you would
like to access from your container.

:::{.callout-tip}

To run R code or an R script using rocker accessing a shared directory, you
can skip the instructions below and manage to work on the command line. However,
you won't be able to access that directory if you try to login from RStudio's web
browser. It will only work from process launched from the command line.


```{.sh}
podman run 
  -ti \
  --rm \
  --group-add keep-groups \
  -v /shared_dir:/shared_dir \
  docker.io/rocker/rstudio R
```
:::



1. Find out the group ID (GID) of the `rfriends` group.

    ```{.sh}
    getent group rfriends
    rfriends:x:2000:ana,sergio
    ```

    The GID is `2000`, and both `ana` and `sergio` belong to it.

2. Subordinate that GID to your user. You will need administrative permissions:

    ```{.sh}
    sudo usermod --add-subgids 2000-2000 ana
    ```

3. Update your Podman rootless namespace:

    ```{.sh}
    podman system migrate
    ```

You are now able to map the group in the container. How? That depends on your Podman version:


### Podman versions 4.7 and above

To run your container mapping your host GID `2000` to a container GID combine
the `--group-add keep-groups` with the `--gidmap` option:

```{.sh}
podman run \
    --rm \
    --group-add keep-groups \
    --gidmap="+g102000:@2000" \
    --volume /shared_dir:/shared_dir \
    docker.io/rocker/rstudio
```

You will have used `--group-add keep-groups` so the user in the container still belongs to
the subordinated group. The `--gidmap` argument takes care of appending the mapping of group
`2000` from the host to group `102000` in the container. Additioning `100 000` to your GID is an
easy way to remember the container GID and avoid collisions with lower container GIDs.


### Podman versions below 4.7

The command will look like:

```{.sh}
podman run  \
    --rm  \
    --group-add keep-groups \
    --uidmap "0:0:65535"  \
    --gidmap "0:0:1" \
    --gidmap "102000:1:1" \
    --gidmap "1:2:60000" \
    --volume /shared_dir:/shared_dir \
    docker.io/rocker/rstudio
```

You can notice several differences in the idmapping command:

- You must provide a default user id mapping: `--uidmap "0:0:65535"`
- You must provide a full group id mapping:

    * The group id mapping should map intermediate GID 0 to container GID 0.
      `--gidmap "0:0:1"` This maps your user to root.

    * You must find out the intermediate GID mapping for the GID you want to map 
      (using `podman unshare cat /proc/self/gid_map`).
      

        ```{.sh}
        podman unshare cat /proc/self/gid_map
        #          0       1000          1
        #          1       2000          1
        #          2     100000      65536
        ```

      By looking at the table above, you can find host GID `2000` in the middle
      column and see it is mapped to intermediate id `1` in the left column.
      
      So your mapping must include intermediate GID `1` to container GID `102000`:
      `--gidmap 102000:1:1`

    * And you must map container IDs from 1 to n, using free intermediate GIDs.
      Here we map 60000: `--gidmap "1:2:60000"`.

And happy coding!



---
title: "Running Rootless"
description: Rootless containers and rocker
---

## Rootless containers, security and root

Docker traditionally ran as the `root` user. Users who wanted to run docker
containers needed to be given `sudo` access and use `sudo docker`, or be added
to the `docker` group, so they could run docker without typing `sudo` first. In
both cases, they were running docker with root privileges.

This is considered a bad security practice because it effectively grants root
host privileges to all docker users. However, namespaces and control groups where
not as mature when docker started as they are now, and no better alternative
was available. But we have an alternative now. Docker offers the possibility to
run in [rootless](https://docs.docker.com/engine/security/rootless/) mode and
[podman](https://podman.io/) runs rootless by design.

Running a container rootless does not mean that the container does not have
any root-like capabilities, it means that the container engine does not run
as root.

**For most rocker-related projects, running rootless is a security advantage.**


### Who are we?

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

### Using apt-get inside a rootless container

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

### Modifying files

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

### Port binding

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

## Rootless containers and file permissions

If you have a bit of experience with containers you have probably suffered
of "permission issues".

The typical issue with permissions is that you mount a directory into the
container, and the processes in the container write files in that directory
with a user id different than yours (usually root). Once you are out of the
container you can't access or modify those files.

### How users work in rootless containers

With rootless containers, even if you are only one user, your container
has to behave (read and write files...) as if there were many users. There is
no way to magically do this, so the host operating system actually gives you
many "subordinate user ids" and "subordinate group ids" for you to use as you
wish. *How many?* Usually around 65k user ids and 65k group ids. When you use
a rootless container you may be impersonating up to 65k users! Since it would
be a very bad idea to impersonate other users in your computer (impersonating
root would be the most dangerous) the system administrator gives you unassigned
user ids that do not overlap with anyone else. The list of subordinate user and
group ids assigned to each user is stored in `/etc/subuid` and `/etc/subgid`
files.

```{.sh}
cat /etc/subuid
# sergio:100000:65536
# ana:165536:65536
```

This file is read as follows:

- The user `sergio` has assigned 65536 additional subordinate user IDs starting at 100000.
  This spans the range 100000-165535.
- The user `ana` has assigned 65536 additional subordinate user IDs starting at 165536.
  This spans the range 165536-231071.

When you start a container, the user and group ids used by the image should be
mapped to the host. The default user mapping in podman maps the 0 container uid
(corresponding to the container root user) to your real user id in the host,
and all your subordinate user IDs are mapped to user ids `1:n` in the container.
The same applies to group id mapping.

### Working alone

In the container, you can use user ids without issues (e.g. you can be root).

If you bind mount a directory that you own:

- If you create a file as the root user in the container, outside of it the
  file will be owned by you.
- If you create a file as the container UID 1000, outside of the container will
  appear to be owned by one of your subordinate IDs (e.g. 100999)

What about mounting directories that you DO NOT own?

- The files and directories that you do not own belong to host UIDs that are
  not mapped into the container, so when the container asks for their UID
  the operating system returns the "overflow user id", which is the ID 65534 by
  default and usually are listed as owned by `nobody` or `nogroup`.


### Sharing data with others

If you usually work with a directory shared with other users, it is possible
that the shared directory belongs to a group you all belong to.

There are several possible solutions. Here we describe two of them that we can
use in `rocker`. 

#### Set groups in the running process `--group-add keep-groups`

:::{.callout-important}

Adding `--group-add keep-groups` to `podman run` works when running an R session
or an R script, but not when logging in from the rstudio server website.

See below for an alternative

:::


By belonging to a group you may have permissions to do things (e.g. write to
your shared directory). The ones who actually *do* things are processes that
you start and you own. Your processes usually inherit your user id and your
groups, and based on those groups they are authorized to do things.

When `podman run` starts the initial process in the container the process running
there will typically have the root uid and the root gid inside the container,
which map to your own UID and GID. There are reasons for not inheriting
all your extra group ids:

- The other group IDs are not mapped inside the container, so they are of little
  use there.
- The other group IDs may give permissions to do things in the host that the
  container should never be able to do (e.g. access some particular device).

However, `podman run` accepts `--group-add keep-groups`. When that option is
enabled, `podman` starts the initial process in the container. That process will
have your GID (mapped to the root GID in the container) and all your other extra
groups, unmapped in the container.

On the host:

```{.sh}
id
# uid=1000(sergio) gid=1000(sergio) groups=1000(sergio),4(adm),27(sudo),109(lpadmin),124(sambashare)
```

On the container:

```{.sh}
podman run --rm rocker/rstudio id
# uid=0(root) gid=0(root) groups=0(root)
```

Keeping groups:

```{.sh}
podman run --rm --group-add keep-groups rocker/rstudio id
# uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
```

Note how when keeping groups all the unmapped groups are grouped into 65534 (nogroup).


Even if the container process can't see those groups, when the process tries to read or
write a file it has the groups set, so it actually has the permissions to work.

On web applications such as RStudio, where the user logs in through the web browser,
the process with the R session is not started directly by podman, but instead it is
started by RStudio server when the user logs in.

In this scenario, the started process does not inherit the groups from the host,
and can't write files into your shared directories.

:::{.callout-tip}


To run R code or an R script using rocker accessing a shared directory, you
can use `--group-add keep-groups`.

```{.sh}
podman run -ti --rm -v /shared_dir:/shared_dir \
  --group-add keep-groups rocker/rstudio R
```

However you won't be able to access that directory if you try to login from the web browser.

:::


#### Ask the system administrator to subordinate the group

:::{.callout-important}

This solution is complicated. There is a discussion open at
[podman#18333](https://github.com/containers/podman/issues/18333) to attempt to simplify it.

:::

Let's assume here that the shared directory belongs to the GID 2000.

Your system administrator can subordinate to you and your colleagues that GID, so you can use it:

```{.sh}
cat /etc/subgid
# sergio:100000:65536
# ana:165536:65536
#
# sergio:2000:1
# ana:2000:1
```

Now `sergio` and `ana` can use the GID 2000 (note the /etc/sub**g**id).

You will have to map your group host ID into the container so the container
can access it. There are two caveats:

- When providing a custom mapping you need to provide a complete `uidmap`
  and a complete `gidmap`.

- When providing either of those two mappings in rootless `podman`, instead of
  mapping to the container from the host, we map to the container from podman's
  intermediate mapping.


The first caveat will require us to provide some default identity mappings.
The second caveat will require us to find out what's the intermediate podman
mapping, so we know the intermediate group ID of our host 2000 gid.

The intermediate group mapping is found with the following command:

```{.sh}
podman unshare cat /proc/self/gid_map
#          0       1000          1
#          1       2000          1
#          2     100000      65536
```

The table shows that gid 2000 in the host (middle column) is mapped to
intermediate gid 1 (left column).

We will map

| Type  | Container ID | Intermediate ID | Reason                                                                               |
| ----- | ------------ | --------------- | ------------------------------------------------------------------------------------ |
| User  |  0 - 65534   |   0 - 65534     | Identity mapping (no change needed in user mapping besides the default one)          |
| Group |      0       |       0         | Identity mapping (our main host GID 1000, was mapped to intermediate 0 by default)   |
| Group |  1 - 65534   |   2 - 65535     | We skip intermediate GID 1, so 1->2, 2->3...                                         |
| Group |   100000     |       1         | We map container GID 100000 to intermediate GID 1, that we saw matches host GID 2000 |


The `--uidmap` and `--gidmap` options in rootless podman map those intermediate
uids/gids to container ids:

```{.sh}
podman run  \
  --rm  \
  -v /shared_dir:/shared_dir \
  --uidmap "0:0:65535"  \
  --gidmap "0:0:1" \
  --gidmap "1:2:65535" \
  --gidmap "100000:1:1" \
  --group-add keep-groups \
  rocker/rstudio
```

With all that set:

- Our rocker image will be able to obtain a container group id for the host gid 2000
- It will add the root user to that group in the container's `/etc/groups` file
- **When you log in from the rstudio website, you will have access to the shared directory.**


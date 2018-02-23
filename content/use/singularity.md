---
title: "Singularity"
---

[Singularity](http://singularity.lbl.gov/) is useful for running containers as an unprivileged user, especially in multi-user environments like High-Performance Computing clusters.
Rocker images can be imported and run using Singularity, with optional custom password support.

### Importing a Rocker Image

Use the `singularity pull` command to import the desired Rocker image from Docker Hub into a SquashFS (compressed, read-only) image:

```
singularity pull --name rstudio.simg docker://rocker/rstudio:latest
```

If additional Debian software packages are needed, see the Singularity documentation for building a [writable image](http://singularity.lbl.gov/docs-flow#writable-image) or [writable sandbox directory](http://singularity.lbl.gov/docs-flow#sandbox-folder) (note that sudo privileges are required).
A writable image is not needed for installing R packages into a personal library in the user's home directory.

### Running a Rocker Singularity container (localhost, no password)

```
singularity exec rstudio.simg rserver --www-address=127.0.0.1
```

This will run rserver in a Singularity container.
The `--www-address=127.0.0.1` option binds to localhost (the default is 0.0.0.0, or all IP addresses on the host).
listening on 127.0.0.1:8787.

### Running a Rocker Singularity container with password authentication

To enable password authentication, set the PASSWORD environment variable and add the `--auth-none=0 --auth-pam-helper-path=pam-helper` options:

```
PASSWORD='...' singularity exec rstudio.simg rserver --auth-none=0  --auth-pam-helper-path=pam-helper
```

After pointing your browser to http://_hostname_:8787, enter your local user ID on the system as the username, and the custom password specified in the PASSWORD environment variable.

### SLURM job script

On an HPC cluster, a Rocker Singularity container can be started on a compute node using the cluster's job scheduler, allowing it to access compute, memory, and storage resources that may far exceed those found in a typical desktop workstation.
The following example illustrates how this may be done with a SLURM job script.

```
#!/bin/sh
#SBATCH --time=08:00:00
#SBATCH --signal=USR2
#SBATCH --ntasks=1
#SBATCH --cpus-per-tasks=2
#SBATCH --mem=8192
#SBATCH --output=/home/%u/rstudio-server.job.%j

export RSTUDIO_PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${USER}@LOGIN-HOST

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${USER}
   password: ${PASSWORD}
END

# This example bind mounts the /project directory on the host into the Singularity container.
# By default the only host file systems mounted within the container are $HOME, /tmp, /proc, /sys, and /dev.
singularity exec --bind=/project rstudio.simg \
    rserver --www-port ${PORT} --auth-none=0 --auth-pam-helper-path=pam-helper
printf 'rserver exited' 1>&2
```

The job script is submitted using the SLURM `sbatch` command:

```
$ sbatch rstudio-server.job
Submitted batch job 123456
```

After the scheduled job begins execution, `rserver` is started in a Singularity container, and the connection information (including the compute node hostname, TCP port, and a randomly-generated custom password) is sent in the job script stderr to a file in the user's home directory named `rstudio-server.job.123456`.

The `rserver` process (and resulting rsession process after login) will persist until:
1. The job wall time (`--time=08:00:00`, or 8 hours) is reached.
    + The `--signal=USR2` directive tells SLURM to send SIGUSR2 approximately 60 seconds before the wall time limit is reached.
      This causes the `rsession` process to save user's session state to their home directory, so it can be resumed in a subsequent job.
2. The SLURM `scancel` command is used to cancel the job.

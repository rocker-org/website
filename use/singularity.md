---
title: "Singularity"
description: Run RStudio Server containers by Singularity.
aliases:
  - /use/singularity/
---

[Singularity](https://www.sylabs.io/guides/latest/user-guide/) is useful for running containers as an unprivileged user, especially in multi-user environments like High-Performance Computing clusters.
Rocker images can be imported and run using Singularity, with optional custom password support.

## Importing a Rocker Image

Use the `singularity pull` command to import the desired Rocker image from Docker Hub into a (compressed, read-only) Singularity Image File:

```bash
singularity pull docker://rocker/rstudio:4.2
```

If additional Debian (or other) software packages are needed, a Rocker base image can be extended in a [Singularity definition file](https://sylabs.io/guides/3.7/user-guide/definition_files.html).
Note that sudo privileges are required to use the `singularity build` command, unless using a remote builder such as the [Sylabs Cloud Remote Builder](https://cloud.sylabs.io/builder).
Alternatively, a Rocker base image can be extended in a Dockerfile and a Singularity image built using the [docker2singularity](https://github.com/singularityhub/docker2singularity) Docker image.
Modifications to the base Rocker image are not needed for installing R packages into a personal library in the user's home directory.

## Running a Rocker Singularity container (localhost, no password)

```bash
mkdir -p run var-lib-rstudio-server

printf 'provider=sqlite\ndirectory=/var/lib/rstudio-server\n' > database.conf

singularity exec \
   --bind run:/run,var-lib-rstudio-server:/var/lib/rstudio-server,database.conf:/etc/rstudio/database.conf \
   rstudio_4.2.sif \
   /usr/lib/rstudio-server/bin/rserver --www-address=127.0.0.1
```

This will run rserver in a Singularity container.
The `--www-address=127.0.0.1` option binds to localhost (the default is 0.0.0.0, or all IP addresses on the host).
listening on 127.0.0.1:8787.

## Running a Rocker Singularity container with password authentication

To enable password authentication, set the PASSWORD environment variable and add the `--auth-none=0 --auth-pam-helper-path=pam-helper` options:

```bash
PASSWORD='...' singularity exec \
   --bind run:/run,var-lib-rstudio-server:/var/lib/rstudio-server,database.conf:/etc/rstudio/database.conf \
   rstudio_4.2.sif \
   /usr/lib/rstudio-server/bin/rserver --auth-none=0 --auth-pam-helper-path=pam-helper --server-user=$(whoami)
```

After pointing your browser to http://_hostname_:8787, enter your local user ID on the system as the username, and the custom password specified in the PASSWORD environment variable.

## Additional Options for RStudio >= 1.3.x

In addition, RStudio >= 1.3.x enforces a stricter policy for session timeout, defaulting to 60 Minutes. You can opt in to the legacy behaviour by adding the following parameters:

```default
--auth-timeout-minutes=0 --auth-stay-signed-in-days=30
```

## SLURM job script

On an HPC cluster, a Rocker Singularity container can be started on a compute node using the cluster's job scheduler, allowing it to access compute, memory, and storage resources that may far exceed those found in a typical desktop workstation.
A per-user /tmp should be bind-mounted when running on a multi-tenant HPC cluster that has singularity configured to bind mount the host /tmp, to avoid an existing /tmp/rstudio-server owned by another user.

The following example illustrates how this may be done with a SLURM job script.

```sh
#!/bin/sh
#SBATCH --time=08:00:00
#SBATCH --signal=USR2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8192
#SBATCH --output=/home/%u/rstudio-server.job.%j
# customize --output path as appropriate (to a directory readable only by the user!)

# Create temporary directory to be populated with directories to bind-mount in the container
# where writable file systems are necessary. Adjust path as appropriate for your computing environment.
workdir=$(python -c 'import tempfile; print(tempfile.mkdtemp())')

mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END

# Set OMP_NUM_THREADS to prevent OpenBLAS (and any other OpenMP-enhanced
# libraries used by R) from spawning more threads than the number of processors
# allocated to the job.
#
# Set R_LIBS_USER to a path specific to rocker/rstudio to avoid conflicts with
# personal libraries from any R installation in the host environment

cat > ${workdir}/rsession.sh <<END
#!/bin/sh
export OMP_NUM_THREADS=${SLURM_JOB_CPUS_PER_NODE}
export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.2
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END

chmod +x ${workdir}/rsession.sh

export SINGULARITY_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server"

# Do not suspend idle sessions.
# Alternative to setting session-timeout-minutes=0 in /etc/rstudio/rsession.conf
# https://github.com/rstudio/rstudio/blob/v1.4.1106/src/cpp/server/ServerSessionManager.cpp#L126
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0

export SINGULARITYENV_USER=$(id -un)
export SINGULARITYENV_PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@LOGIN-HOST

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${SINGULARITYENV_USER}
   password: ${SINGULARITYENV_PASSWORD}

When done using RStudio Server, terminate the job by:

1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:

      scancel -f ${SLURM_JOB_ID}
END

singularity exec --cleanenv rstudio_4.2.sif \
    /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} \
            --auth-none=0 \
            --auth-pam-helper-path=pam-helper \
            --auth-stay-signed-in-days=30 \
            --auth-timeout-minutes=0 \
            --rsession-path=/etc/rstudio/rsession.sh
printf 'rserver exited' 1>&2
```

The job script is submitted using the SLURM `sbatch` command:

```bash
$ sbatch rstudio-server.job
Submitted batch job 123456
```

After the scheduled job begins execution, `rserver` is started in a Singularity container, and the connection information (including the compute node hostname, TCP port, and a randomly-generated custom password) is sent in the job script stderr to a file in the user's home directory named `rstudio-server.job.123456`.

The `rserver` process (and resulting rsession process after login) will persist until:

1. The job wall time (`--time=08:00:00`, or 8 hours) is reached.
   1. The `--signal=USR2` directive tells SLURM to send SIGUSR2 approximately 60 seconds before the wall time limit is reached.
      This causes the `rsession` process to save user's session state to their home directory, so it can be resumed in a subsequent job.
2. The SLURM `scancel` command is used to cancel the job.

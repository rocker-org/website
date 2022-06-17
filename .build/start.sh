#!/bin/bash

## Create a user whose uid matches the owner of the bind mount directry.

MOUNT_DIR="$1"
DEFAULT_USER=docker

# Check the permissions of the bind mount.
if [ -d "$MOUNT_DIR" ]; then
    user_id=$(stat "${MOUNT_DIR}" -c "%u")
    group_id=$(stat "${MOUNT_DIR}" -c "%g")

    # Check if the user is non-root user
    if [ "$user_id" = "0" ]; then
        DEFAULT_USER=
    elif [ -z "$(getent passwd "${USER_NAME}")" ]; then
        groupadd -g "$group_id" "$DEFAULT_USER"
        useradd -u "$user_id" -g "$group_id" -s /bin/bash -m "$DEFAULT_USER"
    fi
fi

su "$DEFAULT_USER" -c "quarto preview --host 0.0.0.0 --port 8000 --no-browser"

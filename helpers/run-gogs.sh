#!/bin/bash

# Discover user/group
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Fix non-root execution
grep -v "^${GOGS_USER}" /etc/passwd > "${HOME}/passwd"
echo "${GOGS_USER}:x:${USER_ID}:${GROUP_ID}:gogs.io user:${HOME}:/bin/bash" >> "${HOME}/passwd"
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${HOME}/passwd
export NSS_WRAPPER_GROUP=/etc/group

# Executes Gogs service
USER=${GOGS_USER} ${GOGS_PATH}/gogs web

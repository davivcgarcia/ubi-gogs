#!/bin/bash

# Discover user/group
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Fix non-root execution
grep -v "^${GOGS_USER}" /etc/passwd > "${GOGS_WORKDIR}/helpers/passwd"
echo "${GOGS_USER}:x:${USER_ID}:${GROUP_ID}:gogs.io user:${GOGS_HOMEDIR}:/bin/bash" >> "${GOGS_WORKDIR}/helpers/passwd"
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${GOGS_WORKDIR}/helpers/passwd
export NSS_WRAPPER_GROUP=/etc/group

# Executes Gogs service
HOME=${GOGS_HOMEDIR} USER=${GOGS_USER} PORT=${GOGS_PORT} ${GOGS_WORKDIR}/gogs web

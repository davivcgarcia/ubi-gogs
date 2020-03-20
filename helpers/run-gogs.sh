#!/bin/bash

# Discover user/group
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Fix non-root execution
grep -v "^${GOGS_USER}" /etc/passwd > "${GOGS_HOMEDIR}/passwd"
echo "${GOGS_USER}:x:${USER_ID}:${GROUP_ID}:gogs.io user:${GOGS_HOMEDIR}:/bin/bash" >> "${GOGS_HOMEDIR}/passwd"
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${GOGS_HOMEDIR}/passwd
export NSS_WRAPPER_GROUP=/etc/group

# Executes Gogs service
USER=${GOGS_USER} ${GOGS_PATH}/gogs web

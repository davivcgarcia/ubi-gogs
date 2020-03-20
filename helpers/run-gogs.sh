#!/bin/bash

# Discover user/group
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Fix non-root execution
grep -v "^${GOGS_USER}" /etc/passwd > "${GOGS_WORK_DIR}/passwd"
echo "${GOGS_USER}:x:${USER_ID}:${GROUP_ID}:gogs.io user:${GOGS_WORK_DIR}:/bin/bash" >> "${GOGS_WORK_DIR}/passwd"
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${GOGS_WORK_DIR}/passwd
export NSS_WRAPPER_GROUP=/etc/group

# Executes Gogs service
USER=${GOGS_USER} ${GOGS_WORK_DIR}/gogs web

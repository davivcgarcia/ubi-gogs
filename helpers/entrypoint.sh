#!/bin/bash

#
# Discover user/group used on execution
#

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

#
# Enables rootless execution
#

grep -v "^${GOGS_USER}" /etc/passwd > "${GOGS_WORKDIR}/nss_wrapper-passwd"
echo "${GOGS_USER}:x:${USER_ID}:${GROUP_ID}:gogs.io user:${GOGS_HOMEDIR}:/bin/bash" >> "${GOGS_WORKDIR}/nss_wrapper-passwd"
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${GOGS_WORKDIR}/nss_wrapper-passwd
export NSS_WRAPPER_GROUP=/etc/group

#
# Expose common environment variables
#

export USER=${GOGS_USER}
export HOME=${GOGS_HOMEDIR}
export LANG=en_US.UTF-8

#
# Executes user provided command instead of default
#

if [ "$1" != 'run-gogs' ]; then
  exec "$@"
  exit $?
fi

#
# Executes default command defined on Dockerfile
#

${GOGS_WORKDIR}/gogs web
exit $?

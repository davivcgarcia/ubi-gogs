#
# Redistributable base image from Red Hat based on RHEL 8
#

FROM registry.access.redhat.com/ubi8/ubi

#
# Metadata information
#

LABEL name="Gogs UBI Image" \
      vendor="Gogs" \
      maintainer="Davi Garcia <davivcgarcia@gmail.com>" \
      build-date="2020-03-24" \
      version="${GOGS_VERSION}" \
      release="2"

#
# Environment variables used for build/exec
#

ENV GOGS_VERSION=0.11.91 \
    GOGS_USER=gogs \
    GOGS_WEB_PORT=3000 \
    GOGS_SSH_PORT=3022 \
    GOGS_BASEDIR=/opt \
    GOGS_WORKDIR=/opt/gogs \
    GOGS_DATADIR=/opt/gogs/data \
    GOGS_HOMEDIR=/home/gogs \
    YUM_OPTS="--setopt=install_weak_deps=False --setopt=tsflags=nodocs"

#
# Copy helper scripts to image
#

COPY helpers/* /usr/bin/

#
# Install requirements and application
#

RUN yum ${YUM_OPTS} -y install git nss_wrapper && \
    yum -y clean all && \
    cd ${GOGS_BASEDIR} && \
    curl -L https://dl.gogs.io/${GOGS_VERSION}/gogs_${GOGS_VERSION}_linux_amd64.tar.gz | tar -xz && \
    mkdir ${GOGS_DATADIR} && \
    cd ${GOGS_WORKDIR}

#
# Prepare the image for running on OpenShift
#

RUN useradd -m -g 0 ${GOGS_USER} && \
    chgrp -R 0 ${GOGS_HOMEDIR} ${GOGS_WORKDIR} ${GOGS_DATADIR} && \
    chmod -R g+rwX ${GOGS_HOMEDIR} ${GOGS_WORKDIR} ${GOGS_DATADIR}

USER ${GOGS_USER}

#
# Set application execution parameters
#

EXPOSE ${GOGS_WEB_PORT} ${GOGS_SSH_PORT}
WORKDIR ${GOGS_WORKDIR}

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["run-gogs"]

FROM registry.access.redhat.com/ubi8/ubi

ENV GOGS_VERSION 0.11.91
ENV GOGS_BASEDIR /opt
ENV GOGS_WORK_DIR ${GOGS_BASEDIR}/gogs
ENV GOGS_DATADIR ${GOGS_WORK_DIR}/data
ENV GOGS_PORT 3000
ENV GOGS_USER git
ENV GOGS_HOMEDIR /home/${GOGS_USER}

ADD helpers ${GOGS_PATH}/helpers

RUN yum -y install git nss_wrapper gettext && \
    yum -y clean all && \
    cd ${GOGS_BASEDIR} && \
    curl -L https://dl.gogs.io/${GOGS_VERSION}/gogs_${GOGS_VERSION}_linux_amd64.tar.gz | tar -xz && \
    useradd -m -u 1000 -g 0 ${GOGS_USER} && \
    mkdir ${GOGS_DATADIR} && \
    chgrp -R 0 ${GOGS_HOMEDIR} ${GOGS_WORK_DIR} ${GOGS_DATADIR} && \
    chmod -R g+rwX ${GOGS_HOMEDIR} ${GOGS_WORK_DIR} ${GOGS_DATADIR} && \
    cd ${GOGS_WORK_DIR}

EXPOSE 3000 22

USER ${GOGS_USER}
WORKDIR ${GOGS_WORK_DIR}

CMD ["sh", "-c", "${GOGS_PATH}/helpers/run-gogs.sh"]

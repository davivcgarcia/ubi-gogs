# ubi-gogs
[![Docker Repository on Quay](https://quay.io/repository/davivcgarcia/ubi-gogs/status "Docker Repository on Quay")](https://quay.io/repository/davivcgarcia/ubi-gogs)

Unofficial image for Gogs based on Red Hat Universal Base Image v8

## Why another image?

This image was build using the [Red Hat Universal Base Image (UBI) 8](https://developers.redhat.com/products/rhel/ubi/), which provides a stable foundation to workloads running on mission-critical environments, specially on **Red Hat OpenShift Container Platform**.

## How to use?

If you running standalone containers, you can use `podman` or `docker` with:

```bash
podman run -d -p 3000:3000 -p 3022:3022 quay.io/davivcgarcia/ubi-gogs
```

If you running containers on OpenShift/Kubernetes, and have dynamic provisioning enabled, you can use `kubectl` or `oc` to deploy a `StatefulSet` with:

```bash
oc apply -f https://raw.githubusercontent.com/davivcgarcia/ubi-gogs/master/resources/openshift-statefulset.yaml
```

Or, if you prefer to use `Deployment` controller, use:

```bash
oc apply -f https://raw.githubusercontent.com/davivcgarcia/ubi-gogs/master/resources/openshift-deployment.yaml
```

If you don't have dynamic provisioning for PersistentVolumes enabled, please create the required `PersistentVolume` resources and map them to the `PersistentVolumeClaim` resources before deployment.

## How to configure?

If you are running it on OpenShift/Kubernetes, you will notice that the resource template is configured to use container volumes at `/opt/gogs/data` and `/opt/gogs/custom`, mapped to `PersistentVolumes`. You need to use this path to configure Gogs' (repositories and logs path).

Also, you could use `SQLite` as database, storing the file at `/opt/gogs/data`. But the prefered way is to setup a PostgreSQL database and use it instead.

## Any support?

This is a community project, not backed nor supported by Red Hat.

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

If you running containers on OpenShift/Kubernetes, and have dynamic provisioning enabled, you can use `kubectl` or `oc` to deploy it redirectly from this repo:

```bash
oc apply -f https://raw.githubusercontent.com/davivcgarcia/ubi-gogs/master/resources/openshift.yaml
```

If you don't have dynamic provisioning for PersistentVolumes enabled, please create the required `PersistentVolume` resources and map them to the `PersistentVolumeClaim` resources before deployment.

## How to configure?

If you are running it on OpenShift/Kubernetes, you will notice that the resource template is configured to use container volumes at `/opt/gogs/data` and `/opt/gogs/custom`, mapped to `PersistentVolumes`. You need to use the path `/opt/gogs/data` to configure Gogs to store its repositories data. You could use it to persists logs too, but the recomendation is to enable console output.

The container can run using any unprivileged user ID, which will be mapped automaticaly to user `gogs` and used to run the application. So configure to use this user instead of the default `git`.

By default, the container will be listening internally on port `tcp/3000`, so do not change it when configuring. You could also enable native SSH service, using internal port `tcp/3022`. When using standalone containers, map these ports to available local ports. If you are running containers on Kubernetes/OpenShift, you can use Ingress/Routes exposed as `tcp/80 (HTTP)` or `tcp/443 (HTTPS)` redirecting to `tcp/3000` (mechanism is created by default) and Service type NodePort/LoadBalancer for `tcp/3022` (need manual setup).

Also, you could use `SQLite` as database, storing the file at `/opt/gogs/data`. But the prefered way is to setup a PostgreSQL database and use it instead.

## Any support?

This is a community project, not backed nor supported by Red Hat.

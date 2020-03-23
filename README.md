# ubi-gogs
[![Docker Repository on Quay](https://quay.io/repository/davivcgarcia/ubi-gogs/status "Docker Repository on Quay")](https://quay.io/repository/davivcgarcia/ubi-gogs)

Unofficial image for Gogs based on Red Hat Universal Base Image v8

## Why another Gogs container image?

This image was build using the [Red Hat Universal Base Image (UBI) 8](https://developers.redhat.com/products/rhel/ubi/), which provides a stable foundation to workloads running on mission-critical environments, specially on **Red Hat OpenShift Container Platform**.

## How to use it?

If you running standalone containers, you can use `podman` or `docker` with:

```bash
podman run -it -p 3000:3000 --user 21241 quay.io/davivcgarcia/ubi-gogs
```

If you running containers on Kubernetes (including the OpenShift distribution), and have Dynamic Provisioning for storage enabled, you can use `kubectl` or `oc` to deploy a `StatefulSet` with:

```bash
kubectl apply -f https://raw.githubusercontent.com/davivcgarcia/ubi-gogs/master/resources/openshift-statefulset.yaml
```

Or, if you prefer to use `Deployment` controller, use:

```bash
kubectl apply -f https://raw.githubusercontent.com/davivcgarcia/ubi-gogs/master/resources/openshift-deployment.yaml
```

## Any support?

This is a community project, not backed nor supported by Red Hat.

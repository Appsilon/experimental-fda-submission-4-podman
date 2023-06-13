# Podman FDA Submission Pilot 4

Proof of concept by [Appsilon](https://appsilon.com/) based on [Pilot 2](https://github.com/RConsortium/submissions-pilot2/).

## Requirements

[Install Podman](https://podman.io/docs/installation) locally _(in Ubuntu it can be installed via `sudo apt install qemu-system podman -y.`)_

🔴 Please note that the configuration file `/etc/containers/registries.conf` must contain `ghcr.io` or `docker.io` as a valid registry.
Searching for the `r-ver` image should get multiple results.

You might also need to authenticate using `podman login <name of registry>`

```bash
podman search r-ver
# This should output some results, such as:
# NAME                                     DESCRIPTION
# docker.io/rocker/r-ver                Reproducible builds to fixed versions of R
# ...
```

## Run the container locally

There are 2 methods to run the container:

1. Using the image directly via `podman`
1. Using a `docker-compose.yml` configuration with `podman-compose` _(it may not be installed by default with podman)_

### Run the container with podman

After running the container, the Teal application is available at `http://localhost:8787`.

```bash
podman machine init
git clone --recurse-submodules https://github.com/Appsilon/experimental-fda-submission-4-podman
cd experimental-fda-submission-4-podman
podman build . --tag experimental-fda-submission-4-podman
podman pod create --publish 8787:8787 pilot-pod
podman run -dt --pod pilot-pod experimental-fda-submission-4-podman:latest
```

### Run the container with podman-compose

After running the container, the Teal application is available at `http://localhost:8787`.

```bash
podman-compose up -d --pull
```

## Screenshot of the Pilot running

![Screen shot of the teal application running in the container](screenshot.png)

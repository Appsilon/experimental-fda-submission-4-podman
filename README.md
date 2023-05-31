# Podman FDA Submission Pilot 4

Proof of concept by [Appsilon](https://appsilon.com/) based on [Pilot 2](https://github.com/RConsortium/submissions-pilot2/).

## Requirements

[Install Podman](https://podman.io/docs/installation) locally, for example, in Ubuntu it can be installed via `sudo apt install qemu-system podman -y.`

🔴 Please note that the configuration file `/etc/containers/registries.conf` must contain a valid registry.
Searching for an image should get results _(the example below has docker.io as a registry)_.

```bash
podman search r-base
# This should output some results, such as:
# NAME                                     DESCRIPTION
# docker.io/library/r-base                 R is a system for statistical computation an...
```

## Run the container locally with podman

```bash
podman machine init
git clone --recurse-submodules https://github.com/Appsilon/experimental-fda-submission-4-podman
cd experimental-fda-submission-4-podman
podman build . --tag experimental-fda-submission-4-podman
podman pod create --publish 8787:8787 pilot-pod
podman run -dt --pod pilot-pod experimental-fda-submission-4-podman:latest
```

## Screenshot of the Pilot running

![](screenshot.png)

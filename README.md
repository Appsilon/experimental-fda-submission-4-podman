# Podman FDA Submission Pilot 4

> Container that runs Shiny Application with Pilot 2 submission

Proof of concept Shiny container by [Appsilon](https://appsilon.com/) based on [Pilot 2](https://github.com/RConsortium/submissions-pilot2/) from the RConsortium.

**Overview**

* Builds container image with [Pilot 2](https://github.com/RConsortium/submissions-pilot2/) for container-based submission
* Easy reproducibility without having to install R environment and packages
  * Using `podman-compose` the process only needs 1 command
  * Manually building it via `podman` uses 3 commands
* Based on OpenSource [Podman](https://podman.io/)
* Supports rapid development with cached environment (see [development guide](development_guide.md))

## Installation and Requirements

Refer the [installation_guide.md](installation_guide.md) for installation steps for [Windows](installation_guide.md#windows), [Mac OSX](installation_guide.md#macos) and [Ubuntu](installation_guide.md#ubuntu

## Steps to run the Pilot-4 app

### Step 1 - Download / clone the repository

```
git clone --recurse-submodules https://github.com/Appsilon/experimental-fda-submission-4-podman
cd experimental-fda-submission-4-podman
```

### Step 2 - Run the container locally

There are 2 methods to run the container. Using `podman` or `podman-compose`

### Step 2A - Creating and running a container via `podman`

After running the container, the Pilot-4 application can be accessed in the browser at `http://localhost:8787`.

```bash
podman build . --tag experimental-fda-submission-4-podman
podman pod create --publish 8787:8787 --name pilot-pod
podman run -dt --pod pilot-pod experimental-fda-submission-4-podman:latest
```

### Step 2B - Run the container with `podman-compose`

After running the container, the Pilot-4 application can be accessed in the browser at `http://localhost:8787`.

```bash
podman-compose up -d --pull
```

## Screenshot of the Pilot running

![Screen shot of the teal application running in the container](screenshot.png)

### Appendix

#### Using GitHub Container Registry

The user can use a different container registry from the default `docker.io` by changing the `BUILD ARGS` of the docker image.
It needs to change the `IMAGE_REGISTRY=ghcr.io` and `IMAGE_ORG=rocker-org` to appropriate values.
The organization also needs to change as it has different usernames in `docker.io` (rocker) and `ghcr.io` (rocker-org).

A preliminary step to login to GitHub registry is required, you can use your own GitHub username and password, or your personal access token (`PAT`).

```bash
podman login ghcr.io --username <your-username-here>

# or if you already a personal access token
echo $PAT | podman login ghcr.io --username <your-username-here> --password-stdin
```

After login, to change the registry to GitHub you can use one of the methods below:

1. Running podman via command line
2. Edit the `Dockerfile` file
3. Edit the `docker-compose.yml` file

1\. To build the image in the command line by running:

```bash
podman build . --build-arg IMAGE_REGISTRY=ghcr.io --build-arg IMAGE_ORG=rocker-org --tag experimental-fda-submission-4-podman
```

2\. Edit the `Dockerfile` file by changing the following ARGS:

```
# ...
ARG IMAGE_REGISTRY=ghcr.io
ARG IMAGE_ORG=rocker-org
# ...

# build the image by running:
# podman build . --tag experimental-fda-submission-4-podman
```

3\. Edit the `docker-compose.yml` by changing the `service.pilot-4-podman.build.args`:

ℹ️ note: This can be done by changing the existing example in `docker-compose.yml` or creating a new service with the different registry.

```dockerfile
# edit the lines below
# ...
  build:
    context: .
    args:
      IMAGE_ORG: rocker
      IMAGE_REGISTRY: docker.io
# ...

# build the image using podman-compose by running:
# podman-compose build --pull pilot-4-podman
```

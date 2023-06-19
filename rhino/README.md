# Podman FDA Submission Pilot 4 (Rhino-based)

> Container that runs Shiny Application based in Rhino with Pilot 2 submission

Proof of concept Shiny container by [Appsilon](https://appsilon.com/) based on [Pilot 2](https://github.com/Appsilon/rhino-fda-pilot-2-submission/) from the RConsortium and adapted to use Rhino framework.

## Requirements

[Install Podman](https://podman.io/docs/installation) locally _(in Ubuntu it can be installed via `sudo apt install qemu-system podman podman-compose -y.`)_

Clone the repository and initialize the git modules _(`submission-pilot2` with the default Golem-based Application and `rhino/pilot2-modified` with Rhino-based application)_.

```
$ git clone --recurse-submodules https://github.com/Appsilon/experimental-fda-submission-4-podman
$ cd experimental-fda-submission-4-podman/rhino
```

## Run the container locally

We recommend to use `podman-compose` to run the container to simplify the process.

However, the container can run in the 2 methods described in the README on the root directory of this repository. Please refer to that document on how to run the container manually using `podman` command.


### Run the container with podman-compose

After building and running the container, the Teal application is available at `http://localhost:9797`. Note that the port is `9797`.

```bash
# Make sure the current directory is `/rhino`
$ podman-compose up -d --pull
```

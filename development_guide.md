# Development Guide

## Mounting volumes

If you wish to mount files from the host machine to the Docker containers you can do so with the help of volumes.

One use case for this is that you have a container with all the required code to run the Shiny app but you would like to run the Shiny app for different datasets and you don't want to wait around for the new Docker image to build with your new dataset. By mounting the new datasets you can simply source your new dataset to the containers.

In this case, let's assume that we want to change the four xpt files inside the `datasets/adam`: `adadas.xpt`, `adlbc.xpt`, `adsl.xpr`, and `adtte.xpt`. We can do this by running this command.

```bash
podman run -dt --pod pilot-pod -v ./submissions-pilot2/datasets:/home/shiny/submissions-pilot2/datasets experimental-fda-submission-4-podman:latest
```

You can change the `./submissions-pilot2/datasets` with any location to mount that particular directory. The syntax of the volume mount is `PATH_IN_THE_HOST_MACHINE:PATH_IN_CONTAINER`

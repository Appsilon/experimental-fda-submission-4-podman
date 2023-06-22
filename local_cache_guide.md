# Development guide

> How to setup local environment and use local cache to speed up

This guide will show how to cache the packages locally to speed up the build of the container image.

There are 2 methods to do it:

* **Container-based**:: Building the container image with the `renv_cache` directory _(from the host)_ mounted as a volume in the container.
    * This is the recommended method that relies solely on the container image and does not need to install R nor any of the packages' system dependencies
* **Host R**:: Setting up the cache in the host by using an R console
    * Requires a valid R environment set on the host _(with the correct R-version)_

## Container-based _(recommended)_

This method uses the container defined in `Dockerfile` with `renv_cache` directory _(from the host)_ mounted as a volume in the container.
It doesn't need R installed.

🟡 If you run the commands bellow, then **you will need to build the image again without the volume mounted** in the container.

### Step 1: Populate `{renv}` cache

The commands below will populate the cache in the host's directory.

```bash
podman build . --tag experimental-fda-submission-4-podman --volume $(pwd)/renv_cache:/renv_cache

# (optional) Command to build the cache for the rhino-based submission
#  Note that there are more build args and the R version used is v4.3.0
podman build . --tag experimental-fda-submission-4-podman --volume $(pwd)/renv_cache:/renv_cache --build-arg R_VERSION=4.3.0 --build-arg LOCAL_DIR=./rhino/pilot2-modified --build-arg R_SCRIPT=./rhino/entrypoint.R
```

### Step 2: Build image

Please refer to the instructions on the main [README](README.md#steps-to-run-the-pilot-4-app) on how to build the image _(note: building without mounted volumes)_.

With the folder `renv_cache` pre-populated, the container image doesn't have to download and install the packages, which speeds up development.

## Host R

This method requires to have R installed locally and an internet connection to retrieve all packages.

We only recommend this method if the R package dependencies is not stable

### Step 1: Populate `{renv}` cache

Open an R console at the root of this repository and run the code chunk below _(step 1A or 1B, depending on the image that is being built)_.

Both steps will populate the `renv_cache` folder with a valid cache for that R version.
The two caches can co-exist without issues as `{renv}` creates a namespace base on the version.

#### Step 1A: Pilot2 original image

🟡 R version `4.2.x` needs to be used to build the cache correctly.

```R
Sys.setenv(RENV_PATHS_ROOT = file.path(getwd(), "renv_cache"))
renv::load(file.path(getwd(), "submissions-pilot2"))
renv::restore()
```

#### Step 1B: Pilot2 Rhino image

This step is the same as 1A, however it uses a different R version and paths

🟡 R version `4.3.x` needs to be used to build the cache correctly.

```R
Sys.setenv(RENV_PATHS_ROOT = file.path(getwd(), "renv_cache"))
# Required unless having GITHUB_PAT set in environment variables (personal access token)
options("renv.config.install.remotes" = FALSE)
renv::load(file.path(getwd(), "rhino/pilot2-modified"))
renv::restore()
```

### Step 2: Build image

Please refer to the instructions on the main [README](README.md#steps-to-run-the-pilot-4-app) on how to build the image.

With the folder `renv_cache` pre-populated, the Container image doesn't have to download and install the packages itself.

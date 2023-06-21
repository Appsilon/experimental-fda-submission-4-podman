# Development guide

> How to setup local environment and use local cache to speed up

This guide will show how to cache the packages locally to speed up the build of the container image.
It requires to have R installed locally and an internet connection to retrieve all packages.

### Step 1: Populate `{renv}` cache for faster image build

Open an R console at the root of this repository and run the code chunk below _(step 1A or 1B)_.

This will populate the `renv_cache` folder with a valid cache.

#### Step 1A: Pilot2 original image

🟡 Please note that it needs R `v4.2.x` to build the correct package versions.

```R
Sys.setenv(RENV_PATHS_ROOT = file.path(getwd(), "renv_cache"))
renv::load(file.path(getwd(), "submissions-pilot2"))
renv::restore()
```

#### Step 1B: Pilot2 Rhino image

This step is the same as 1A, however it uses a different R version and paths

🟡 Please note that it needs R `v4.3.x` to build the correct package versions.

```R
Sys.setenv(RENV_PATHS_ROOT = file.path(getwd(), "renv_cache"))
options("renv.config.install.remotes" = FALSE)
renv::load(file.path(getwd(), "rhino/pilot2-modified"))
renv::restore()
```

### Step 2: Build image

Please refer to the instructions on the main [README](README.md#steps-to-run-the-pilot-4-app) on how to build the image.

With the folder `renv_cache` pre-populated, the Container image doesn't have to download and install the packages itself.

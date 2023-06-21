# Development guide

> How to setup local environment and use local cache to speed up

This guide will show how to cache the packages locally to speed up the build of the container image.
It requires to have R installed locally and an internet connection to retrieve all packages.

We support 2 methods

## Step 1: Open R console and restore Packages

Open an R console at the root of this repository and run the following code chunk

```R
Sys.setenv(RENV_PATHS_ROOT = file.path(getwd(), "renv_cache", ".cache"))
renv::load(file.path(getwd(), "submissions-pilot2"))
renv::restore()
```

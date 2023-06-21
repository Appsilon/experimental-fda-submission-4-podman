## Installation and Requirements

### Windows

1. Install [Podman Desktop](https://podman-desktop.io/downloads/Windows)

2. Install [WSL 2 from the Microsoft Store](https://apps.microsoft.com/store/detail/windows-subsystem-for-linux/9P9TQF7MRM4R)

3. Install python and pip if not already present. Then install the `podman-compose` package using the following command:

   ```bash
   pip install podman-compose
   ```

4. Open the `Control panel` -> Open `Turn Windows feature on or off` -> Make sure that the `Windows Hypervisor Platform` is checked. Restart the computer if you just checked it.

5. Create a new Podman machine in the Podman Desktop by going to the `Settings` -> `Resources` -> `Create new Podman machine`

   Alternatively, this can be done by running the following command

   ```bash
   podman machine init
   ```

### Ubuntu

1. Install [Podman Desktop](https://podman-desktop.io/downloads/Linux)

2. Install `podman-compose` using apt or PyPl

   ```
   sudo apt install qemu-system podman podman-compose -y
   ```

   or

   ```bash
   pip install podman-compose
   ```

3. Create a new Podman machine in the Podman Desktop by going to the `Settings` -> `Resources` -> `Create new Podman machine`

   Alternatively, this can be done by running the following command

   ```bash
   podman machine init
   ```

### MacOS

1. Install [Podman Desktop](https://podman-desktop.io/downloads/MacOS)

   Alternatively, you can install it using brew

   ```
   brew install podman
   ```

2. Install `podman-compose` using homebrew or PyPl

   ```bash
   brew install podman-compose
   ```

   or

   ```bash
   pip install podman-compose
   ```

3. Create a new Podman machine in the Podman Desktop by going to the `Settings` -> `Resources` -> `Create new Podman machine`

   Alternatively, this can be done by running the following command

   ```bash
   podman machine init
   ```

#### Private images

If you plan to use a private image you need to configure registries so Podman has access to pulling them. You can do this in the `Settings` -> `Registries`

However, this repository does not use any private image so this step is not required.

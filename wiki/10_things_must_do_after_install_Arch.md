# 10 Things Must Do After Install Arch

## Configure Pacman

- Edit file `/etc/pacman.conf` and uncomment the following lines:

```bash
Color # Enable colors in pacman output
ParallelDownloads = 5 # Parallel downloads
```

## Automatic Cleaning The Package Cache

```bash
sudo pacman -S pacman-contrib
```

Activate the package timer

```sh
sudo systemctl enable paccache.timer
```

## Install microcode

Microcode is a layer of low-level code that helps the CPU understand and execute instructions. Updating the microcode can fix bugs, improve stability, and sometimes enhance performance. On Linux systems, including Arch Linux, microcode updates are often necessary to address vulnerabilities like Spectre and Meltdown.

1. Determine Your CPU Type

```sh
lscpu | grep Vendor
```

- **Intel**: The output will include "GenuineIntel."
- **AMD**: The output will include "AuthenticAMD."


2. Install the Appropriate Microcode Package
  Based on your CPU type, install the corresponding microcode package using pacman.

- For Intel CPUs:

```sh
sudo pacman -S intel-ucode
```

- For AMD CPUs:

```sh
sudo pacman -S amd-ucode
```

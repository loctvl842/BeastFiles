## Introduction:
This documentation outlines the steps to install and configure `nvidia` on an Arch Linux system with both AMD and NVIDIA GPUs.

## Installation

- Install driver
```sh
sudo pacman -S nvidia
```

- Next, create a Xorg configuration file for the NVIDIA GPU. Create a file like `/etc/X11/xorg.conf.d/20-nvidia.conf` and add the following content:
```conf
Section "ServerLayout"
    Identifier "layout"
    Screen 0 "amdgpu"
    Inactive "nvidia"
EndSection

Section "Device"
    Identifier "amdgpu"
    Driver "amdgpu"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"
    BusID "PCI:1:0:0"  # Use the correct PCI bus ID for your NVIDIA GPU
EndSection
```

- Adjust the BusID with the correct value for your GTX 1650. You can find the BusID by running lspci | grep NVIDIA.
- Save the file and restart your X server (or simply reboot your computer).
- Check `nvidia-smi`

## Troubleshooting

1. **Check for Errors During Boot:**
- During the boot process, look for any error messages related to the NVIDIA driver. To do this, you can view the system logs:
```sh
journalctl -b | grep NVRM
```
This command will display log entries related to NVIDIA. Any error messages here can help diagnose the issue.

2. **modprobe: ERROR: could not insert 'nvidia': No such device**
- Check GPU Availability:
```sh
lspci | grep NVIDIA
```
- Checking Log using command:
```sh
journalctl | grep NVRM
```

Sample log:
```txt
The NVIDIA probe routine was not called for 1 device(s).
Oct 13 22:50:03 beast kernel: NVRM: This can occur when a driver such as: 
                              NVRM: nouveau, rivafb, nvidiafb or rivatv 
                              NVRM: was loaded and obtained ownership of the NVIDIA device(s).
Oct 13 22:50:03 beast kernel: NVRM: Try unloading the conflicting kernel module (and/or
                              NVRM: reconfigure your kernel without the conflicting
                              NVRM: driver(s)), then try loading the NVIDIA kernel module
                              NVRM: again.
Oct 13 22:50:03 beast kernel: NVRM: No NVIDIA devices probed.
```

- This error suggests that another kernel module has taken ownership of the NVIDIA, which is preventing the NVIDIA driver from loading. It specifically mentions drivers such as `nouveu`, `rivafb`, `nvidiafb`, or `rivatv`
- Fix above error by adding it to blacklist
    1. **Create a blacklist file `/etc/modprobe.d/nvidia.conf`**
    2. **Add the module to blacklist**
    ```conf
    blacklist nouveau
    ```
    3. **Update the initial RAM filesystem**
    ```sh
    sudo mkinitcpio -P
    ```
    4. **Reboot**

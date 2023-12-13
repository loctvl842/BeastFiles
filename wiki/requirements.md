## X server

```sh
sudo pacman -S xorg xorg-server xorg-xinit
```

## Git
```sh
sudo pacman -S git github-cli
```

## wget
```sh
sudo pacman -S wget
```

## yay
```sh
sudo pacman -Syu
sudo pacman -S base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Remove `yay` folder cloned after finish installation.

## Shell (Zsh)

**1. Installation:**
```sh
sudo pacman -S zsh
```

**2. Make `zsh` as default shell:**
```sh
chsh -s /bin/zsh
```

**3. Install `zsh` plugin manager:**
```sh
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

**4. Config:**
```sh
cd ~/BeastFiles/config/
stow zsh -t ~
```

## Window manager

**1. Installation:**
```sh
sudo pacman -S bspwm sxhkd
```

**2. Config:**
```sh
cd ~/BeastFiles/config/
stow bspwm -t ~
stow sxhkd -t ~
```

## Languages

**1. Generate Locales:**

Edit file `/etc/locale.gen`
```sh
en_US.UTF-8 UTF-8
vi_VN.UTF-8 UTF-8
```

Generate Locales
```sh
sudo locale-gen
```

**2. Set the System Locale:**

Edit file `/etc/locale.conf`
```conf
LANG=en_US.UTF-8
```

**3. Set User-Specific Locale:**

Edit file `~/.config/locale.conf`
```conf
LANG=vi_VN.UTF-8
```

**Install `ibus`:**
```sh
sudo pacman -S ibus
```

**Install `ibus-bamboo`:**
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/BambooEngine/ibus-bamboo/master/archlinux/install.sh)"
```

**Edit file `/etc/profile` with this content:**

```sh
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# Dành cho những phần mềm dựa trên qt4
export QT4_IM_MODULE=ibus
# Dành cho những phần mềm dùng thư viện đồ họa clutter/OpenGL
export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus
```

Or just run this command:
```sh
sudo sh -c "echo  '\                                            
export GTK_IM_MODULE=ibus\
export QT_IM_MODULE=ibus\
export XMODIFIERS=@im=ibus\
# Dành cho những phần mềm dựa trên qt4\
export QT4_IM_MODULE=ibus\
# Dành cho những phần mềm dùng thư viện đồ họa clutter/OpenGL\
export CLUTTER_IM_MODULE=ibus\
export GLFW_IM_MODULE=ibus\
' >> /etc/profile"
```

**Start ibus on login:**

Add to `$HOME/.config/xinit/xprofile`:

```xprofile
ibus-daemon -drx &
```

**NOTE:**
- `ibus-bamboo`: 
    - choose "chế độ gõ mặc định", then choose `XTestFakeKeyEvent`
    - choose "kiểu gõ", then choose `Telex2`

## Sound

**1. Installation:**
```sh
sudo pacman -S pulseaudio pavucontrol
```

**2. Commands:**
- Volumne up:
```sh
pactl set-sink-volume @DEFAULT_SINK@ +1%
```
- Volumne down:
```sh
pactl set-sink-volume @DEFAULT_SINK@ -1%
```
- Toggle mute:
```sh
pactl set-sink-mute @DEFAULT_SINK@ toggle
```

## Brightness

**1. Install `brillo`:**
```sh
yay -S brillo
```

**2. Add permission to all users to run `brillo`:**

Add and edit file `/etc/udev/rules.d/backlight-permissions.rules`:
```bash
SUBSYSTEM=="backlight", ACTION=="add", \
RUN+="/bin/chmod 0666 /sys/class/backlight/amdgpu_bl2/brightness", \
RUN+="/bin/chown :video /sys/class/backlight/amdgpu_bl2/brightness"
```

> Reload the rule to apply changes:
```sh
sudo udevadm control --reload-rules
```

Check `video` Group Membership:
```sh
groups
```

If `video` is not listed, add user to `video` group using `usermod`:
```sh
sudo usermod -aG video your_username
```

**Reboot needed**

## Notification

**1. Install `dunst`:**
```sh
sudo pacman -S dunst
```

**2. Config dunst**:
```sh
cd ~/BeastFiles/config
stow dunst -t ~
```

## Android mounting

To seamlessly transfer files between your Android phone and your computer running Arch Linux, follow these steps:


**1. Connect the Phone to the Computer**

Use a USB cable to connect your Android phone to your computer.

**2. Install `simple-mtpfs`**

```sh
yay -S simple-mtpfs
```

This command installs simple-mtpfs, a tool that facilitates the mounting of Android devices.

**3. List Devices**

Run the following command to list connected devices:

```sh
simple-mtpfs -l
```

Sample output:

```sh
1: XiaomiMi-2s (id2) (MTP)
```

Take note of the device ID associated with your Android phone.

**4. Create a Mount Point and Mount the Device**

Navigate to your home directory and create a folder named `phone_mount`:

```sh
mkdir ~/phone_mount
```

Now, mount the Android device using the previously identified device ID:

```sh
simple-mtpfs --device 1 ~/phone_mount
```

Replace 1 with the correct device ID for your setup.

**5. Unmount the Device**

To unmount the Android device, ensure that fuse3 is installed:

```sh
sudo pacman -S fuse3
```

Then, execute the following command:

```sh
fusermount -u ~/phone_mount
```

These steps enable you to easily mount and unmount your Android phone, providing a convenient way to transfer files between your devices.

Or you can use script `_dmtpfs.sh` from `BeastFiles` to mount and unmount your Android phone.

```sh
_dmtpfs.sh
```

**Troubleshoot**
`simple-mtpfs` only allows to read files from the phone, not to write to it.

Therefore, we can use `go-mtpfs`

**Install**:

```sh
yay -S go-mtpfs-git
```

Then mount the device:

```sh
go-mtpfs ~/phone_mount &
```

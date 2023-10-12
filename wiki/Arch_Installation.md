## Pre-installation

- Download Arch Linux ISO [here](https://archlinux.org/download/)
- Insert USB drive
- Make sure to umount the drive with the following command:

```sh
sudo umount /dev/sdX
```

> Replace `/dev/sdX` with actual USB device identifier

- Flash the ISO to USB drive
```sh
sudo dd if=/path/to/archlinux.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

- Eject the USB drive:
```sh
sync
sudo eject /dev/sdX
```

## Installation

**Step 1: Boot into the Arch Linux Live Environment:**
**Step 2: Configure the Keyboard Layout:**

```sh
loadkeys layout
```

List all Keyboard layouts:

```sh
ls /usr/share/kbd/keymaps/**/*.map.gz
```

For example, load German layout:
```sh
loadkeys de-latin1
```

**Step 3: Connect to the Internet:**

Using `iwctl`:

```sh
iwctl
```

List all devices:

```sh
device list
```

Get all networks:
```sh
station wlan0 scan
station wlan0 get-networks
```

Connect a network:
```sh
station wlan0 connect "<network name>"
```

```sh
exit
```

**Step 4: Update the System Clock:**

```sh
timedatectl set-ntp true
```

**Step 5: Partition the Disk:**
List all drives available on the system:

```sh
fdisk -l
```

Start partitioning:
```sh
fdisk /dev/<blah> # the biggest one is yours
```
> Alternative: use `cfdisk`

Recommend partitioning:
Laptop (16GB ram, 512GB SSD): `sda1`
- EFI System Partition (ESP):
    - Size: 512 MB
    - Type: EFI System (EF00)
- Swap Partition:
    - Size: 16 GB (Recommend equal to RAM size)
    - Type: Linux Swap (8200)
- Linux Filesystem Partition:
    - Size: (remaining)
    - Type: Linux Filesystem (8300)

**Step 6: Format the Partition:**

1. **Format the EFI System Partition:**
```sh
mkfs.fat -F32 /dev/sdX1
```
2. **Format the Swap Partition:**
```sh
mkswap /dev/sdX2
swapon /dev/sdX2
```
3. **Format the Linux Filesystem Partition (Root):**
```sh
mkfs.ext4 /dev/sdX3
```

**Step 7: Mount the Partition:**
1. Mount the Linux Filesystem Partition:
```sh
mkdir /mnt # (if not existed)
mount /dev/sdX3 /mnt
```

2. Create a directory for the EFI partition and mount it:
```sh
mkdir /mnt/boot/efi
mount /dev/sdX1 /mnt/boot/efi
```

**Step 8: Install the base system:**
```sh
pacstrap /mnt base base-devel linux linux-firmware vim
```

**Step 9: Generate the fstab:**
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

**Step 10: Chroot into the new system:**
```sh
arch-chroot /mnt
```

**Step 11: Set the Time Zone:**
```sh
ln -sf /usr/share/zoneinfo/<your timezone> /etc/localtime
```

Example (Ho Chi Minh City, Vietnam):
```sh
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
```

**Step 12: Generate Locale and Locale-gen:**
Edit file `/etc/locale.gen`, uncomment the line `en_US.UTF-8 UTF-8`, or `vi_VN UTF-8` and save it.

Generate locale:
```sh
locale-gen
```

Choose locale by editting file `/etc/locale.conf`:
```sh
LANG=vi_VN.UTF-8
```

**Step 13: Set the Hostname:**
Edit file `/etc/hostname` (This is the computer's name):

Or run:
```sh
echo myhostname > /etc/hostname
```

Set hosts:
Edit file `/etc/hosts`

```conf
# Static table lookup for hostnames.
# See hosts(5) for details.

127.0.0.1       localhost
::1             localhost
127.0.0.1       beast.localdomain   beast
```

**Step 14: Set the root password:**
```sh
passwd
```

**Step 15: Create a User:**
```sh
useradd -m username
passwd username
```

Make user a member of some groups:
```sh
usermod -aG wheel,audio,video,optical,storage username
```

**Step 16: Configure sudo:**

Install sudo:
```sh
pacman -S sudo
```

Configure sudo:
```sh
visudo
```

Uncomment the line %wheel ALL=(ALL) ALL.

**Step 17: Install and Configure a Boot Loader:**

```sh
pacman -S grub
```

```sh
pacman -S efibootmgr dosfstools os-prober mtools
```

```sh
grub-install --target=x86_64-efi --bootloader-id=grub-uefi --recheck
```

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

**Step 18: Exist the CHroot Environment:**
```sh
exit
```

**Step 19: Umount the Partition and Reboot the System:**
```sh
umount /mnt
reboot
```

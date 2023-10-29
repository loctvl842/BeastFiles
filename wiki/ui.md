## colorls

**[Source](https://github.com/athityakumar/colorls#installation)**
**1. Install Ruby**
**2. Install `colorls`:**
```sh
gem install colorls
```
**3. Config**
```sh
cd ~/BeastFiles/config
stow colorls -t ~
```

## Rofi

**1. Installation:**
```sh
sudo pacman -S rofi
```

**2. Config:**
```sh
cd ~/BeastFiles/config
stow rofi -t ~
```

## Polybar

**1. Installation:**
```sh
sudo pacman -S polybar
```

**2. Config:**
```sh
cd ~/BeastFiles/config
stow polybar -t ~
```

List of app that `polybar` uses:
- cbatticon
- network-manager-applet (nm-applet)
- mictray

## GTK theme

Install [WhiteSur GTK Theme](https://www.gnome-look.org/p/1403328) and [WhiteSur Icons](https://www.gnome-look.org/p/1405756/)

```sh
tar -xvf WhiteSur-yellow.tar.xz
```

Move theme to `~/.themes` and `~/.icons`

**lxappearance**

```sh
sudo pacman -S lxappearance
```

## xscreensaver

**Installation:**
```sh
sudo pacman -S xscreensaver
```

Load this content in `xinit`:
```sh
xscreensaver --no-splash &
```

Then run command:
```sh
xscreensaver-command -lock
```

## LightDM

**Installation:**
```sh
sudo pacman -S lightdm lightdm-webkit2-greeter
```

**Setup theme**:

Download theme:
```sh
sudo git clone https://github.com/paysonwallach/aqua-lightdm-webkit-theme /usr/share/lightdm-webkit/themes/mac/
```

Change theme by edit `webkit-theme` in file `/etc/lightdm/lightdm-webkit2-greeter.conf`

```conf
webkit_theme        = mac
```

Change user's avatar by update `Icon` in file `/var/lib/AccountsService/users/<username>` (Crop a square avatar to put in `/var/lib/AccountsService/icons/`)

```
Session=bspwm
XSession=bspwm
Icon=/var/lib/AccountsService/icons/loc.jpg
SystemAccount=false
```

Remeber to grants full read, write, and execute permissions to the owner of the file:
```sh
chmod 777 /var/lib/AccountsService/users/<username>/icons/<avatar>.jpg
```

Change the background by editing `/etc/lightdm/lightdm-webkit2-greeter.conf`

```conf
background_images = /usr/share/backgrounds/
```

Above command is to tell lightdm the directory where the background image is.

To actually change the background image, update the background in the theme file. (In above theme, edit file `/usr/share/lightdm-webkit/themes/mac/resources/css/style.css`)

**Enable lightdm**:

```sh
sudo systemctl enable lightdm
```

**Troubleshooting:**

1. **Can't login after setup lightdm:**

Edit `/etc/lightdm/lightdm.conf` to change the session from `default` to the name of what we are using (e.g. `bspwm`)

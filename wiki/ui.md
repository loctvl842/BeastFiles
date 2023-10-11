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

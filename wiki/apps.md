## Postman
```sh
yay -S postman-bin
```

## Postgresql

```sh
sudo pacman -S postgresql postgresql-libs
```

## Dbeaver

**Installation**
```sh
sudo pacman -S dbeaver
```

## Gpick

**Installation**
```sh
sudo pacman -S gpick
```

## Thunar

**Installation**
```sh
sudo pacman -S thunar
```

**Plugins:**

- `thunar-archive-plugin`

```sh
sudo pacman -S xarchiver unzip thunar-archive-plugin
```

## Pritunl

Follow [here](https://client.pritunl.com/#install)

```sh
sudo tee -a /etc/pacman.conf << EOF
[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF

sudo pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman -Sy
sudo pacman -S pritunl-client-electron
```

## MPV

A Media player

**Installation**
```sh
sudo pacman -S mpv
```

## LibreOffice

Install stable maintenance branch with relatively rare updates, for conservative users.

```sh
sudo pacman -S libreoffice-still
```


## Visual studio code

```sh
yay -S visual-studio-code-bin
```

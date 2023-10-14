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

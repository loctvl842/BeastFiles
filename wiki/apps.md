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

## RedisInsight

1. Download AppImage from this [link](https://redis.io/insight/#insight-form)

2. Execute the downloaded file

```sh
./Redis-Insight-linux-x86_64.AppImage
```

3. Make global command
```sh
sudo mv Redis-Insight-linux-x86_64.AppImage /usr/local/bin/redis-insight
```

4. Optional: Create a Desktop Entry

Edit file `/usr/share/applications/redis-insight.desktop`

```ini
[Desktop Entry]
Name=Redis Insight
Exec=/usr/local/bin/redis-insight
Icon=/usr/share/pixmaps/redisinsight.png
Type=Application
Categories=Development;Database;
```

**NOTE**: About `icon`, we can extract that with this command:

```sh
redis-insight --appimage-extract
```

- Above is the global command we created earlier, so we can use this to extract the icon, it will create folder named `squashfs-root` in the current directory. Inside this folder, look for an icon file, which is often located in the squashfs-root/usr/share/icons or squashfs-root/ directory. Common icon formats are .png or .svg.
- Once you find the icon, move it to a standard location (such as /usr/share/pixmaps/ or ~/.local/share/icons/).
- Use this path in your .desktop file. For example:




5. Refresh Desktop Database (Optional)

```sh
sudo update-desktop-database
```

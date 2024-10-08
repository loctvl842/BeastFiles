## fzf

```sh
sudo pacman -S fzf
```

## htop

**Install**
```sh
sudo pacman -S htop
```

**Config**
```sh
cd ~/BeastFiles/config
stow htop -t ~
```

## neofetch

**Install**
```sh
sudo pacman -S neofetch
```

**Config**
```sh
cd ~/BeastFiles/config/
stow neofetch -t ~
```

In order to see the logo image, install `imagemagick`
```sh
sudo pacman -S imagemagick
```

## ranger

**Install**
```sh
sudo pacman -S ranger
```

**Config**
```sh
cd ~/BeastFiles/config
stow ranger -t ~
```

**Drag and drop feature**
```sh
git clone https://github.com/mwh/dragon.git ~/dragon
cd ~/dragon
make install
rm -rf ~/dragon
```

**Preview Image during ranger**
```sh
yay -S ueberzug
```

## gitmoji
Gitmoji is an initiative to standardize and explain the use of emojis on GitHub commit messages.

**Install:**
```sh
npm i -g gitmoji-cli
```

## flameshot

This is a screenshot utility.

**Install:**
```sh
sudo pacman -S flameshot
```

**Config:**
```sh
cd ~/BeastFiles/config
stow flameshot -t ~
```

## live-server

```sh
sudo npm install -g live-server
```

## Dot Files

![BeastFiles](https://user-images.githubusercontent.com/80513079/212870165-db43c120-cccd-4384-b7fe-85bdd63823db.png)

Check my **Neovim** config [loctvl842/nvim](https://github.com/loctvl842/nvim#neovim-config)

## 🔒 Requirement

- `stow`
- `git`

## 📦 Installation

Clone into your `$HOME` directory

```bash
git clone https://github.com/loctvl842/BeastFiles
```

Change directory to `BeastFiles/config`

```bash
cd BeastFiles/config
```

To install a package configuration, list all folders'name in directory `BeastFiles/config` and `stow` the config you want

```bash
stow nvim -t ~
```

In order to prevent `GNU Stow` from collapsing multiple symbolic links to the same file or directory into a single link, use `--no-folding` option

```bash
stow -t ~ --no-folding alacritty
```

This option is useful if you want to keep the symbolic links in your package directory separate, rather than having them all be merged into a single link

In order to install all packages

```bash
stow -t ~ *
```

## 🤟Fonts

**Emoji**
- [NotoColorEmoji](https://github.com/googlefonts/noto-emoji)

**Icon**
- [material-design-iconic-font](https://github.com/zavoloklom/material-design-iconic-font/releases/download/2.2.0/material-design-iconic-font.zip)
- [codicon](https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf)

**Text**
- [Cascadia Code](https://github.com/microsoft/cascadia-code/releases)
- [Hack](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)
> Install Mono will get small icons
- [Fira Code](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
- [San Francisco Pro](https://drive.google.com/file/d/1-vLGyDO-q7ciBclaPWY5ObLoPYfyh1q8/view)

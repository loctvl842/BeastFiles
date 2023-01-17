## Dot Files
![BeastFiles](https://user-images.githubusercontent.com/80513079/212870165-db43c120-cccd-4384-b7fe-85bdd63823db.png)

### ✍ Requirement
- `stow`
- `git`

### 📦 Installation
Clone into your `$HOME` directory
```bash
git clone https://github.com/loctvl842/BeastFiles
```

To install a package configuration, list all folders'name in directory `BeastFiles` and `stow` the config you want
```bash
stow nvim
```

In order to prevent `GNU Stow` from collapsing multiple symbolic links to the same file or directory into a single link, use `--no-folding` option
```bash
stow --no-folding alacritty
```
This option is useful if you want to keep the symbolic links in your package directory separate, rather than having them all be merged into a single link

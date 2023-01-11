## Dot Files
![beast](https://user-images.githubusercontent.com/80513079/211482618-06ec34d6-ae6e-47ae-a79c-9a859b498863.png)

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
stow --no-folding nvim
```
This option is useful if you want to keep the symbolic links in your package directory separate, rather than having them all be merged into a single link

In order to stow dot files for example `.git` folder, use the following command:
```bash
stow --dotfiles nvim
```
Install everything:
```
stow --no-folding .
```

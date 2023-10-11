## NodeJS

**Install `npm`:** (This will include installing `nodejs` and `npm` packages)

```sh
sudo pacman -S npm
```

**Install `yarn`:**

```sh
sudo npm install -g yarn
```

## Python

**Install `python3`:**
```sh
sudo pacman -S python3
```

**Install `pip`:**
```sh
sudo pacman -S python-pip
```

**Create Virtual Environment:**
```sh
python3 -m venv .venv
```

**Activate the virtual environment:**
```sh
source .venv/bin/activate
```

**Create a `requirements.txt`:**
```sh
pip freeze > requirements.txt
```

**Quick command line install `Conda`**
```sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
```
> **Source:** https://docs.conda.io/projects/miniconda/en/latest/

###Conda Usage:
**1. Update Conda:**
```sh
conda update conda
```

**2. Create a Conda Environment:**
```sh
conda create --name myenv python=3.x
```

**3. Activate the environment:**
```sh
conda activate myenv
```

**4. Install packages:**
```sh
conda install <package-name>
```

**5. Deactivate the Environment:**
```sh
conda deactivate
```

**6. List Environment:**
```sh
conda env list
```

**7. Remove Environment:**
```sh
conda env remove -n myenv
```

**8. Export the Environment:**

You can export the environment configuration to a YAML file:

```sh
conda env export > env.yaml
```

To recreate the environment elsewhere, you can use:
```sh
conda env create -f environment.yml
```

Generate the requirements.txt file for the specific environment:
```sh
conda list --export -n myenv > requirements.txt
```

## Ruby

```sh
sudo pacman -S ruby
```

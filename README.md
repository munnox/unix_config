This is a simple git repo for storing my terminal configuration for reference.

This can allow the setting to moving to other computers

Right now use:

```bash
wget https://gitlab.com/munnox/unix_config/-/raw/main/deploy/install_nix.sh
bash install_nix.sh

# For deploy shell
nix develop gitlab:munnox/unix_config
# For applying the home manager to local user
nix run gitlab:munnox/unix_config#applyhome
```

## If Docker or Podman is installed try:

### To get a ubuntu machine setup

```bash
./ctl build ubuntu
./ctl d ubuntu
./ctl a ubuntu
./ctl rm ubuntu
```

### To get a NIXOS machine setup

The following allow develop shell

```bash
./ctl build nixos
./ctl d nixos
./ctl a nixos
./clt rm nixos
```


## Go further and clone:

```bash
# Clone HTTPS
git clone https://gitlab.com/munnox/unix_config.git
# Clone GIT
git clone git@gitlab.com:munnox/unix_config.git 

# Add other main remote for redundancy
git remote rename origin lab
git remote add hub git@github.com:munnox/unix_config.git 
git remote add pri git@munnoxtech.com:robert/unix_config.git 

git push --set-upstream hub main
git push --set-upstream pri main
# git remote rename pri origin

git submodule foreach --recursive git f
git submodule foreach --recursive git la
```
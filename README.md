This is a simple git repo for storing my terminal configuration for reference.

This can allow the setting to moving to other computers

Right now use:

```
wget https://gitlab.com/munnox/unix_config/-/raw/main/deploy/install_nix.sh
bash install_nix.sh

# For deploy shell
nix develop gitlab:munnox/unix_config
# For applying the home manager to local user
nix run gitlab:munnox/unix_config#applyhome
```

Go further:

```
# Clone HTTPS
git clone https://gitlab.com/munnox/unix_config.git
# Clone GIT
git clone git@gitlab.com:munnox/unix_config.git 
This is a simple git repo for storing my terminal configuration for reference.

This can allow the setting to moving to other computers

Right now use:

```
# For deploy shell
nix develop gitlab:munnox/unix_config
# For applying the home manager to local user
nix run gitlab:munnox/unix_config#applyhome
```
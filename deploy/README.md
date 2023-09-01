# Unix Config Deploy

Small deploy scripts and helpers

```bash
nix-shell
# Install the ansible collections and roles
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml

# force update
ansible-galaxy collection install -r requirements.yml --force
```
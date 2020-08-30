# SSH config and setup

Config can be placed:

* `/etc/ssh/ssh_config`
* `~/.ssh/config`

Example

```
# Further info `man ssh_config`
host dev
    hostname example.com
    user ubuntu
    # IdentityFile ~/.ssh/id_rsa
    ForwardX11 no
    # Setup a sock v4/v5 proxy set this up in firefox
    # and this then forward all web traffic to the remote server while connected
    # DynamicForward 8080
    # allow port 3000 on remote accessiable locally
    Localforward 8000 localhost:8000
```

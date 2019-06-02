# Mounting file system in Linux

## NFS


First need to install nfs-common using `sudo apt install nfs-common`

Then the command to mount a simple nfs file system [1][2][3]. 

```
mount -t nfs <ip>:<path> <local_path>
```

Add to /etc/fstab

```
<ip>:<path> <local_path> nfs default 0 0
```

## Reference

[1](https://www.tecmint.com/how-to-setup-nfs-server-in-linux/)
[2](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04)
[3](https://help.ubuntu.com/lts/serverguide/network-file-system.html.en)

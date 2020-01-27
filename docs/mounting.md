# Mounting file system in Linux

## NFS


First need to install nfs-common using `sudo apt install nfs-common`

Then the command to mount a simple nfs file system [1][2][3]. 

```
mount -t nfs <ip>:<path> <local_path>
```

Add to /etc/fstab more info [4][5]

```
<ip>:<path> <local_path> nfs default 0 0
```

## CIFS

First need to install the cifs-utils using `sudo apt install cifs-utils`

Sources from [6]

On older systems:

```
sudo apt-get install smbfs
```

```
//servername/sharename  /media/windowsshare  cifs  guest,uid=1000,iocharset=utf8  0  0
or
//servername/sharename  /media/windowsshare  cifs  username=msusername,password=mspassword,iocharset=utf8,sec=ntlm  0 0 
or
//servername/sharename /media/windowsshare cifs credentials=/home/ubuntuusername/.smbcredentials,iocharset=utf8,sec=ntlm 0 0
```

this need a cred file

```
cat << EOF > ~/.smbcredentials
username=msusername
password=mspassword
EOF
chmod 600 ~/.smbcredentials # Change permission to protect file
```

I had issues with the mounting of this device. Turns out that the version of the
synology was max SMB 2.0 turning this to vers=3.0 and it worked ok.
It just said "Operation not permitted" rather cryptic.

```
//10.20.30.20/home  /mnt/cifs/home  cifs  uid=1000,gid=1000,rw,credentials=/home/robert/.smbcredentials,iocharset=utf8,vers=3.0  0  0
```

## VMware Share

Source https://docs.vmware.com/en/VMware-Workstation-Player-for-Windows/12.0/com.vmware.player.win.using.doc/GUID-AB5C80FE-9B8A-4899-8186-3DB8201B1758.html
Source https://kb.vmware.com/s/article/60262

```
mount -t vmhgfs .host:/ /home/ubuntu/shares
mount -t vmhgfs .host:/foo /tmp/foo
```

```
/usr/bin/vmhgfs-fuse .host:/mysharedfolder /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other
```

or add the following to the fstab file

```
.host:/ /mnt/hgfs vmhgfs defaults 0 0
```

```
vmhgfs-fuse    /mnt/hgfs    fuse    defaults,allow_other    0    0
.host:/    /mnt/hgfs        fuse.vmhgfs-fuse    defaults,allow_other    0    0
```


## Reference

[1](https://www.tecmint.com/how-to-setup-nfs-server-in-linux/)
[2](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04)
[3](https://help.ubuntu.com/lts/serverguide/network-file-system.html.en)
[4](https://wiki.ubuntu.com/MountWindowsSharesPermanently)
[5](http://www.troubleshooters.com/linux/nfs.htm)
[6](https://wiki.ubuntu.com/MountWindowsSharesPermanently)

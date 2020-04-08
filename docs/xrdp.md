# Getting a stable rdp session on a ubuntu machine

Source <https://help.ubuntu.com/community/xrdp>
Source Google `ubuntu 18.04.4 xrdp blue screen` <https://askubuntu.com/questions/1166568/remote-desktop-blue-screen-after-login>

`lsb_release -sd` Last tested on version 18.04.04 on 2020_04_08 

```
sudo apt-get -y install xrdp
```

`sudo apt-get install xorgxrdp-hwe-18.04`

Then edit `/etc/xrdp/xrdp.ini` normally already set

setting `encrypt_level=high`

open firewall just incase

`sudo ufw allow 3389/tcp`

sudo nano /etc/polkit-1/localauthority.conf.d/02-allow-colord.conf
sudo vim /etc/polkit-1/localauthority.conf.d/02-allow-colord.conf

add the following to the file:

```
polkit.addRule(function(action, subject) {
  if ( ( action.id == “org.freedesktop.color-manager.create-device”
          || action.id == “org.freedesktop.color-manager.create-profile”
          || action.id == “org.freedesktop.color-manager.delete-device”
          || action.id == “org.freedesktop.color-manager.delete-profile”
          || action.id == “org.freedesktop.color-manager.modify-device”
          || action.id == “org.freedesktop.color-manager.modify-profile”
      ) && subject.isInGroup(“{group}”)) {
    return polkit.Result.YES;
  }
});
```

then restart

`sudo /etc/init.d/xrdp restart`

## Troubleshooting

Packages required


orgxrdp/bionic,now 0.9.5-2 amd64 [installed,automatic]
xrdp/bionic,now 0.9.5-2 amd64 [installed]

### Dirty Fix

```
sudo apt-get install xserver-xorg-core
sudo apt-get -y install xserver-xorg-input-all
```



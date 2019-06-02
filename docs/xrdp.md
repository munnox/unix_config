# Getting a stable rdp session on a ubuntu machine

Source <https://help.ubuntu.com/community/xrdp>

```
sudo apt-get -y install xrdp
```

Then edit `/etc/xrdp/xrdp.ini`

setting `encrypt_level=high`

open firewall just incase

`sudo ufw allow 3389/tcp`

sudo nano /etc/polkit-1/localauthority.conf.d/02-allow-colord.conf

addeding the following:

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


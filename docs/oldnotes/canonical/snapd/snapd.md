# Snapd

issue on hyper-v created VM 18.04.02

has issue where it had trouble with snapd

one of the error line was

```
snapd.snap-repair.service is a disabled or a static unit, not starting it.
```

found fix on <https://askubuntu.com/questions/1037431/receiving-the-error-snapd-snap-repair-service-is-a-disabled-or-a-static-unit-n>

important parts are

to get rid of the of process holding the lock:

```
sudo fuser -vki /var/lib/dpkg/lock
# or
sudo fuser -vki /var/lib/dpkg/lock-frontend
```

then try to purge and fix snapd

either 

```
sudo apt purge snapd
sudo dpkg --configure -a
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt install snapd
```

which didn't work as the dpkg would complete

but:

```
sudo dpkg -r snapd gnome-software-plugin-snap
sudo apt update
sudo apt full-upgrade
```

did work fine the machine seems ok and back to normal


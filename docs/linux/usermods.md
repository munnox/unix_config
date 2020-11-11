# User modifications

* Source http://manpages.ubuntu.com/manpages/cosmic/man8/useradd.8.html

Add a user with sudo will take file from `/etc/skel/`

```
sudo useradd -m -G sudo test
```

Remove user with the user directory

```
sudo userdel test -r
```

User defaults in the ubuntu GUI `/etc/xdg/user-dirs.defaults`

and if the user directoy doesn't exist try `mkhomedir_helper username` to use the default config above. This hasn't worked correctly.

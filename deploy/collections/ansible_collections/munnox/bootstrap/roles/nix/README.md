Role Name
=========

WARNING: For Developing and Prototyping Installs!

Install nix on a host. Can be for single or multiuser.
Currently installing for single user as it is more stable and doesn't require user interaction.

Requirements
------------

Needs sudo access to the host.

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

Install nix on the host

Run the main.yml task for this role. 

```
- name: Install NIX on hosts
  hosts: "{{ playbook_groups | default('localhost') }},!disabled"
  tasks:
    - name: Install NIX
      import_role:
        name: munnox.bootstrap.nix
```

License
-------

GPLv3

Author Information
------------------

By Dr Robert Munnoch PhD Meng MIET
Role Name
=========

WARNING: For Developing and Prototyping Installs!

Install a devstack service on a host. Includes a Dashboard by default and reports the tokens back on the logs.

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

Install devstack on a server.

Run the main.yml task for this role. 

```
- name: Run the devstack role (Runs main.yml tasks)
  hosts: "{{ playbook_groups | default('localhost') }},!disabled"
  roles:
    - import_role:
        name: munnox.bootstrap.devstack
        k3s_state: "{{ devstack_state | default('present') }}"
```

```
- name: Install devstack on Hosts
  hosts: "{{ playbook_groups | default('devstack') }},!disabled"
  tasks:
    - name: Install devstack on host with sudo
      import_role:
        name: munnox.bootstrap.devstack
```

License
-------

GPLv3

Author Information
------------------

By Dr Robert Munnoch PhD Meng MIET
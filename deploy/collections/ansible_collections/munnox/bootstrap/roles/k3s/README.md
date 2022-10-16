Role Name
=========

WARNING: For Developing and Prototyping Installs!

Install a K3s service on a host. Includes a Dashboard by default and reports the token back on the logs.

Requirements
------------

Needs sudo access to the host and swap disabled.

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

Install k3s on a server.

Run the main.yml task for this role. 

```
- name: Run the k3s role (Runs main.yml tasks)
  hosts: "{{ playbook_groups | default('localhost') }},!disabled"
  roles:
    - import_role:
        name: munnox.bootstrap.k3s
        k3s_state: "{{ k3s_state | default('present') }}"
```

```
- name: Install K3s on Hosts
  hosts: "{{ playbook_groups | default('k3s') }},!disabled"
  tasks:
    - name: Install K3s on host with sudo and noswap
      import_role:
        name: munnox.bootstrap.k3s
```

License
-------

GPLv3

Author Information
------------------

By Dr Robert Munnoch PhD Meng MIET

Role Name
=========

WARNING: For Developing and Prototyping Installs!

Install a awx service on a host reports the token back on the logs. The web service on (30080) is not protected with HTTPS by default.

Requirements
------------

Needs sudo access to the host and a kubenetes platform available to the logged user.

Role Variables
--------------

None

Dependencies
------------

None
Example Playbook
----------------

Install aws on a server.

Run the main.yml task for this role. 

```
- name: Run the awx role (Runs main.yml tasks)
  hosts: "{{ playbook_groups | default('localhost') }},!disabled"
  roles:
    - import_role:
        name: munnox.bootstrap.awx
        awx_state: "{{ awx_state | default('present') }}"
        awx_namespace: "{{ awx_namespace | default('awx') }}"
```

```
- name: Install AWX on Hosts
  hosts: "{{ playbook_groups | default('awx') }},!disabled"
  tasks:
    - name: Install AWX on kubernets service
      import_role:
        name: munnox.bootstrap.awx
        awx_state: "{{ awx_state | default('present') }}"
        awx_namespace: "{{ awx_namespace | default('awx') }}"
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

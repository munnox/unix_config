Role Name
=========

Common task files are grouped here for inclusion else where. These can be run on their own providing some common utilities.

Summaries of their use can be found below:

* main.yml - Main Common role task file currently it is a placeholder with debug information
* utility_ping_summaery.yml - Print some useful information aobut each host as it is pinged.
* utility_debug_vars.yml - Useful host debug printed information like uptime, host group information and hostvaribles.
* utility_get_memory.yml - Gather hardware information and print the hosts gathered info and free memory.
* utility_get_user_ids.yml - Get the UID in "{{ user_uid }}" and GID "{{ user_gid }}" facts for a username in the varible "{{ username }}".
* utility_list_files.yml - Run "ls" in a directory capturing and printing the result.
* utility_update_package_manager.yml - Update the packages on ubuntu

Requirements
------------

None

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

Please see each utiliy file for examples playbook of their use.

* `tasks/utility_ping_summary.yml`
* `tasks/utility_update_package_manager.yml`
* `tasks/utility_list_files.yml`
* `tasks/utility_get_memory.yml`

Run the main.yml task for this role. This is the default task list but it is mainly a place holder at present to test variables.

```
- name: Run the common role (Runs main.yml tasks)
  hosts: "{{ playbook_groups | default('localhost') }},!disabled"
  roles:
    - import_role:
      name: munnox.bootstrap.common
      state: "{{ testing | default('not defined') }}"
      port: "{{ ansible_port }}"
      message: |
        testing: {{ testing }}
        {{ ansible_port }}
        {{ state }}
```


License
-------

GPLv3

Author Information
------------------

By Dr Robert Munnoch PhD Meng MIET
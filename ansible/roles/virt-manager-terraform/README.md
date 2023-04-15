Role Skeleton
=========

This role installs virt-manager with the right configurations so that it can be used with terraform-provider-libvirt

Requirements
------------

Role Variables
--------------

user_name: this is for appending libvirt to the user groups

Dependencies
------------

Example Playbook
----------------

This is how you can use it

``` yaml
- hosts: pc
  vars:
    user_name: theintegrative
  roles:
    - virt-manager-terraform
```

License
-------

GPL-3.0-or-later

Author Information
------------------

The Integrative: [Website](https://theintegrative.net)

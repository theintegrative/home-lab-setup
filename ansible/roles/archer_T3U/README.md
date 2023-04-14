Role Archer
=========

Installing drivers for archer T3U usb network adapter

Requirements
------------

ansible

Role Variables
--------------

``` shell
# set username inside playbook.yml
user_name: "theintegrative"
```

Dependencies
------------


Example Playbook
----------------

Add the role like this:
``` yaml
- hosts: localhost
  roles:
    - archer_T3U
```

Using the playbook
------------------

To directly use this on your localhost:
```shell
ansible-playbook -i localhost, --connection=local -bK playbook.yml
```

License
-------

GPL-3.0-or-later

Author Information
------------------

The Integrative: [Website](https://theintegrative.net)

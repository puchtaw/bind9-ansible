bind9-ansible
=========

This is simple bind9 installer using ansible-playbook. When forked can be a good repository for your internal DNS configuration. Tested for single zone only.

How To
------------

Create your zone:

- `MY_ZONE=some.myzone make install`

Then adjust A records in `bind/vars/main.yml` and run linters and perform functional tests against a container:

- `make test` 

When ready - deploy with make

- `TARGET=dns.host.myzone make deploy` - run bind.yml playbook

or Ansible:

- `ansible playbook bind.yml -e target=dns.myzone`

You may perform some sanity checks afterwards:

- `make healthcheck` - run e2e tests against deployed bind server

Requirements
------------

- ansible v2.5
- ansible-lint
- shellcheck
- docker
- nslookup

Role Variables
--------------

- `bind/vars/main.yml` - main DNS configuration file.
- `test/run.sh`  - tests
- there must be a file `bind/templates/$(MY_ZONE).zone.j2` but its content is generic (initially in `bind/templates/example.internal.zone.j2`)

Example Playbook
----------------

```
- hosts: my.dns.server
  become: yes
  roles:
    - bind
```

TODO
-------

- CNAME records
- Multiple zones


License
-------

MIT


base:
  '*':
    - users.keys
    - openssh
    - openssh.config
    - openssh.auth
    - software.glances
    - storage.client
    - dotfiles
    - snmp.conf
  'role:vagrant':
    - match: grain
    - software.virtualbox
    - software.vagrant

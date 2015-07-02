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
    - motd
    - timestamp
  'role:vagrant':
    - match: grain
    - software.virtualbox
    - software.vagrant
  'role:desktop':
    - match: grain
    - software.i3.gaps
    - software.i3.i3lock-blur

base:
  '*':
    - grains
    - salt.minion
    - users.keys
    - openssh
    - openssh.config
    - openssh.auth
    - storage.client
    - dotfiles
    - snmp.conf
    - motd
    - software.byobu
    - timestamp
  'role:vagrant':
    - match: grain
    - software.virtualbox
    - software.vagrant
  'role:desktop':
    - match: grain
    - software.insync
  'role:i3':
    - match: grain
    - software.i3.gaps
    - software.i3.i3lock-blur

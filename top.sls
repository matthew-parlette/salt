base:
  '*':
    - grains
    - salt.minion
  'kernel:Linux':
    - match: grain
    - groups
    - users.keys
    - openssh
    - openssh.config
    - openssh.auth
    - dotfiles
    - snmp.conf
    - software.vim
    - shell.zsh
    - sudoers.included
    - timestamp
  'os:Ubuntu':
    - match: grain
    - motd
    - software.byobu
  'role:storage-client':
    - match: grain
    - storage.client
  'role:dns-master':
    - match: grain
    - bind.config
  'role:vagrant':
    - match: grain
    - software.virtualbox
    - software.vagrant
  'G@kernel:Linux and G@role:desktop':
    - match: compound
    - software.insync
    - software.autokey
    - software.synapse
    - software.slack
    - software.indicator-sound-switcher
    - software.truecrypt
    - software.haroopad
    - software.java.jdk
  'role:i3':
    - match: grain
    - software.i3.gaps
    - software.i3.i3lock-blur
  'role:gaming':
    - match: grain
    - software.steam
    - software.mumble
  'role:minecraft-server':
    - match: grain
    - minecraft.server
    - ddclient
  'role:minecraft-map-renderer':
    - match: grain
    - minecraft.map.render
  'role:minecraft-map-host':
    - match: grain
    - minecraft.map.host
    - ddclient
  'role:ask-server':
    - match: grain
    - ask.server
    - ddclient
  'role:haproxy':
    - match: grain
    - haproxy
  'role:mirror':
    - match: grain
    - mirror
  'role:openra-server':
    - match: grain
    - openra.server
    - ddclient

base:
  '*':
    - grains
    - salt.minion
  'kernel:Linux':
    - match: grain
    - users.keys
    - openssh
    - openssh.config
    - openssh.auth
    - storage.client
    - dotfiles
    - snmp.conf
    - motd
    - software.byobu
    - software.vim
    - timestamp
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
  'role:i3':
    - match: grain
    - software.i3.gaps
    - software.i3.i3lock-blur
  'role:gaming':
    - match: grain
    - software.steam
    - software.mumble
  'role:mumble-server':
    - match: grain
    - software.mumble.server
  'role:minecraft-server':
    - match: grain
    - game.minecraft.server
  'role:minecraft-map-renderer':
    - match: grain
    - game.minecraft.render-map
  'role:minecraft-map-host':
    - match: grain
    - game.minecraft.map

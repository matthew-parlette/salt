base:
  '*':
    - grains
    - salt.minion
  'role:salt-master':
    - match: grain
    - salt.master
  'kernel:Linux':
    - match: grain
    - shell.zsh
    - groups
    - users.keys
    - openssh
    - openssh.config
    - openssh.auth
    - dotfiles
    - snmp.conf
    - software.vim
    - software.glances
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
    - bind.ddns
  'role:dhcp-master':
    - match: grain
    - dhcpd.keys
    - dhcpd.config
  'role:vagrant':
    - match: grain
    - software.virtualbox
    - software.vagrant
  'role:development':
    - match: grain
    - node
    - software.yeoman
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
    - software.shutter
    - software.nemo
  'role:desktop':
    - match: grain
    - software.i3.gaps
    # - software.i3.i3lock-blur
    - software.nemo.disable-desktop
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
  'role:openvpn-server':
    - match: grain
    - openvpn
  'role:zenoss-cc-master':
    - match: grain
    - zenoss.user
  'role:nfs-server':
    - match: grain
    - nfs.server
  'role:nfs-client':
    - match: grain
    - nfs.client
    - nfs.mount

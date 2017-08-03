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
    - software.bup
    - timestamp
  'os:Ubuntu and G@osmajorrelease:14':
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
    # - dhcpd.config
  'role:openstack-controller':
    - match: grain
    # - mysql
    # - mysql.remove_test_database
    - pymysql
    - mongodb
    - rabbitmq
    - memcached.config
    - memcached.python_memcached
    - openstack.client
    - keystone
    - glance
    - nova.controller
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
    - software.indicator-sound-switcher
    - software.truecrypt
    - software.java.jdk
    - software.shutter
    - software.nemo
  'role:desktop':
    - match: grain
    - i3.gaps
    - i3.bar.i3pystatus
    - i3.lock.blur
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
  'role:nfs-server':
    - match: grain
    - nfs.server
  'role:nfs-client':
    - match: grain
    - nfs.client
    - nfs.mount
  'role:miriam':
    - match: grain
    - miriam
  'role:n2n-supernode':
    - match: grain
    - n2n.supernode
  'role:n2n-node':
    - match: grain
    - n2n.node
    - n2n.node.hosts
  'role:plex-server':
    - match: grain
    - software.plex.server
  'role:mumble-server':
    - match: grain
    - software.mumble.server
  'role:tribute-dev':
    - match: grain
    - ddclient
    - tribute.development
  'role:tribute':
    - match: grain
    - ddclient
    - tribute
  'role:starbound':
    - match: grain
    - ddclient
    - starbound
  'role:santa-dev':
    - match: grain
    - santa.development
  'role:santa':
    - match: grain
    - santa
    - software.croniter
  'role:mattermost':
    - match: grain
    - mattermost
  'role:grav':
    - match: grain
    - grav

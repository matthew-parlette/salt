base:
  '*':
    - grains
    - salt.minion
  'role:salt-master':
    - match: grain
    - salt.master
    - salt.ssh
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
    - sudoers.included
    - influxdb.python
    - python.jira
  'os:Ubuntu and G@osmajorrelease:14':
    - match: grain
    - software.colorls
    # - motd
    # - software.byobu
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
    - software.glances
    - software.nemo
    - software.nerd-fonts
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
    - letsencrypt
    - letsencrypt.combine
    - ssh.stopped
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
    - docker.clean
  'role:tribute':
    - match: grain
    - ddclient
    - tribute
    - docker.clean
  'role:starbound':
    - match: grain
    - ddclient
    - starbound
    - docker.clean
  'role:santa-dev':
    - match: grain
    - santa.development
    - docker.clean
  'role:santa':
    - match: grain
    - santa
    - software.croniter
    - docker.clean
  'role:mattermost':
    - match: grain
    - mattermost
    - docker.clean
  'role:grav':
    - match: grain
    - grav
    - docker.clean
  'role:dokuwiki':
    - match: grain
    - dokuwiki
    - docker.clean
  'role:openproject':
    - match: grain
    - docker
    - docker.py
    - openproject
    - docker.clean
  'role:grafana':
    - match: grain
    - grafana
  'role:influxdb':
    - match: grain
    - influxdb
  'role:proxmox':
    - match: grain
    # - letsencrypt
    # - proxmox.cert
    - proxmox.repo
  'role:influxdb-minion':
    - match: grain
    - influxdb.databases
  'role:kubernetes-client':
    - match: grain
    - kubernetes.repo
    - kubernetes.kubeconfig
    - kubernetes.helm

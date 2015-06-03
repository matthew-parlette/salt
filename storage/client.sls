python-software-properties:
  pkg.installed

glusterfs-3.5-ppa:
  pkgrepo.managed:
    - ppa: gluster/glusterfs-3.5
    - require_in:
      - pkg: glusterfs-client
    - require:
      - pkg: python-software-properties

glusterfs-client:
  pkg.installed:
    - version: 3.5.3-ubuntu1~{{ grains['lsb_distrib_codename'] }}1

/media/storage:
  file.directory:
    - user: matt
    - group: matt
    - mode: 755
  mount.mounted:
    - device: file01:/storage
    - fstype: glusterfs
    - opts: defaults,_netdev
    - dump: 0
    - pass_num: 0
    - persist: True
    - mkmnt: True
    - require:
      - file: /media/storage
      - pkg: glusterfs-client

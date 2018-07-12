include:
  - ceph.common

ceph-common:
  pkg.installed

admin-secret:
  cmd.run:
    - name: ceph-authtool --name client.admin /etc/ceph/ceph.client.admin.keyring --print-key > /etc/ceph/admin.secret
    - require:
      - file: /etc/ceph/ceph.client.admin.keyring

{%- for mount in salt['pillar.get']('ceph:fs:mounts', []) %}
/mnt/{{ mount }}:
  mount.mounted:
    - device: "{{ salt['pillar.get']('ceph:fs:hosts', [])|join(', ') }}:/"
    - fstype: ceph
    - mkmnt: True
    - persist: True
    - mount: True
    - opts: 
      - _netdev
      - 'name=admin'
      - 'secretfile=/etc/ceph/admin.secret'
    - require:
      - pkg: ceph-common
      - file: common_config
      - cmd: admin-secret
{%- endfor %}

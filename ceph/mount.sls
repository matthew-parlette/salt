include:
  - ceph.common

ceph-fs-common:
  pkg.installed

admin-secret:
  cmd.wait:
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
      - pkg: ceph-fs-common
      - file: common_config
      - cmd: admin-secret
{%- endfor %}

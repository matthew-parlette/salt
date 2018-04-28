{%- from "ceph/map.jinja" import common with context %}

{% if not common.get('container_mode', False) %}

common_packages:
  pkg.installed:
  - names: {{ common.pkgs }}

/etc/default/ceph:
  file.managed:
  - source: salt://ceph/files/env
  - template: jinja
  - require:
    - pkg: common_packages

{%- endif %}

{{ common.prefix_dir }}/etc/ceph:
  file.directory:
  - user: root
  - group: root
  - mode: 755
  - makedirs: True

common_config:
  file.managed:
  - name: {{ common.prefix_dir }}/etc/ceph/{{ common.get('cluster_name', 'ceph') }}.conf
  - source: salt://ceph/files/{{ common.version }}/ceph.conf.{{ grains.os_family }}
  - template: jinja
  {% if not common.get('container_mode', False) %}
  - require:
    - pkg: common_packages
  {%- endif %}


{%- if common.keyring is defined and common.keyring.admin is defined %}

ceph_create_keyring_admin:
  cmd.run:
  - name: "ceph-authtool --create-keyring {{ common.prefix_dir }}/etc/ceph/{{ common.get('cluster_name', 'ceph') }}.client.admin.keyring --gen-key -n client.admin {%- for cap_name, cap in  common.keyring.admin.caps.iteritems() %} --cap {{ cap_name }} '{{ cap }}' {%- endfor %}"
  - unless: "test -f {{ common.prefix_dir }}/etc/ceph/{{ common.get('cluster_name', 'ceph') }}.client.admin.keyring"
  - require:
  {% if not common.get('container_mode', False) %}
    - pkg: common_packages
  {%- endif %}
    - file: common_config

{%- endif %}

{%- if salt['pillar.get']('ceph:common:keyring:admin', None) %}

{{ common.prefix_dir }}/etc/ceph/{{ common.get('cluster_name', 'ceph') }}.client.admin.keyring:
  file.managed:
  - source: salt://ceph/files/keyring
  - template: jinja
  # - unless: "test -f {{ common.prefix_dir }}/etc/ceph/{{ common.get('cluster_name', 'ceph') }}.client.admin.keyring"
  - require:
  {% if not common.get('container_mode', False) %}
    - pkg: common_packages
  {%- endif %}
    - file: common_config
  - require_in:
    - cmd: ceph_create_keyring_admin

{%- endif %}

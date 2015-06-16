{%- set controller = salt['pillar.get']('openstack:controller','localhost') %}
{%- set name = "neutron" %}
{%- set type = "network" %}
{%- set packages = ['neutron-server','neutron-plugin-ml2','python-neutronclient'] %}
{%- set services = ['neutron-server'] %}

{{ name }}-keystone-user:
  keystone.user_present:
    - name: {{ name }}
    - password: {{ salt['pillar.get']('openstack:accounts:' + name,name) }}
    - email: {{ name }}@andromeda
    - roles:
        service:
          - admin

{{ name }}-keystone-service:
  keystone.service_present:
    - name: {{ name }}
    - service_type: {{ type }}
    - description: OpenStack Image Service
    - require:
      - keystone: {{ name }}-keystone-user

{{ name }}-keystone-endpoint:
  keystone.endpoint_present:
    - name: {{ name }}
    - publicurl: http://{{ controller }}:9696
    - internalurl: http://{{ controller }}:9696
    - adminurl: http://{{ controller }}:9696
    - region: RegionOne
    - require:
      - keystone: {{ name }}-keystone-service

{{ name }}-packages:
  pkg.installed:
    - pkgs:
      {%- for package in packages %}
      - {{ package }}
      {%- endfor %}

{%- for service in services %}
{{ service }}:
  service.running:
    - enable: True
    - restart: True
    - require:
      - pkg: {{ name }}-packages
      - keystone: {{ name }}-keystone-endpoint
      - file: /etc/{{ name }}/{{ name }}.conf
    - watch:
      - file: /etc/{{ name }}/{{ name }}.conf
      - file: /etc/{{ name }}/plugins/ml2/ml2_conf.ini
{%- endfor %}

{{ name }}-sync-db:
  cmd.run:
    - name: {{ name }}-db-manage --config-file /etc/{{ name }}/{{ name }}.conf --config-file /etc/{{ name }}/plugins/ml2/ml2_conf.ini upgrade head
    - user: {{ name }}
    - group: {{ name }}
    - watch:
      - file: /etc/{{ name }}/{{ name }}.conf
      - file: /etc/{{ name }}/plugins/ml2/ml2_conf.ini
    - require:
      - file: /etc/{{ name }}/{{ name }}.conf
      - file: /etc/{{ name }}/plugins/ml2/ml2_conf.ini

/etc/{{ name }}/{{ name }}.conf:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/{{ name }}.conf
    - template: jinja
    - require:
      - pkg: {{ name }}-packages

/etc/{{ name }}/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/ml2_conf.ini
    - template: jinja
    - require:
      - pkg: {{ name }}-packages

{%- set controller = salt['pillar.get']('openstack:controller','localhost') %}
{%- set name = "nova" %}
{%- set type = "compute" %}
{%- set packages = ['nova-api','nova-cert','nova-conductor','nova-consoleauth','nova-novncproxy','nova-scheduler','python-novaclient','nova-compute','sysfsutils'] %}
{%- set services = ['nova-api','nova-cert','nova-conductor','nova-consoleauth','nova-novncproxy','nova-scheduler','nova-compute'] %}

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
    - publicurl: http://{{ controller }}:8774/v2/%(tenant_id)s
    - internalurl: http://{{ controller }}:8774/v2/%(tenant_id)s
    - adminurl: http://{{ controller }}:8774/v2/%(tenant_id)s
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
      - file: /etc/{{ name }}/{{ name }}-compute.conf
{%- endfor %}

{{ name }}-sync-db:
  cmd.run:
    - name: {{ name }}-manage db sync
    - user: {{ name }}
    - group: {{ name }}
    - require:
      - file: /etc/{{ name }}/{{ name }}.conf

/etc/{{ name }}/{{ name }}.conf:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/{{ name }}.conf
    - template: jinja
    - require:
      - pkg: {{ name }}-packages

/etc/{{ name }}/{{ name }}-compute.conf:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/{{ name }}-compute.conf
    - template: jinja
    - require:
      - pkg: {{ name }}-packages

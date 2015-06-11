{% set controller = salt['pillar.get']('openstack:controller','localhost') %}
{% set name = "glance" %}
{% set type = "image" %}

{% if salt['pillar.get']('openstack:glance:api:config:glance_store:filesystem_store_datadir',False) %}
{{ name }}-store:
  file.directory:
    - name: {{ salt['pillar.get']('openstack:glance:api:config:glance_store:filesystem_store_datadir') }}
    - user: {{ name }}
    - group: {{ name }}
    - makedirs: True
    - require:
      - pkg: {{ name }}
{% endif %}

{{ name }}-user:
  keystone.user_present:
    - name: {{ name }}
    - password: {{ salt['pillar.get']('openstack:accounts:' + name,'glance') }}
    - email: {{ name }}@andromeda
    - roles:
        service:
          - admin

{{ name }}-service:
  keystone.service_present:
    - name: {{ name }}
    - service_type: {{ type }}
    - description: OpenStack Image Service
    - require:
      - keystone: {{ name }}-user

{{ name }}-endpoint:
  keystone.endpoint_present:
    - name: {{ name }}
    - publicurl: http://{{ controller }}:9292
    - internalurl: http://{{ controller }}:9292
    - adminurl: http://{{ controller }}:9292
    - region: RegionOne
    - require:
      - keystone: {{ name }}-service

{{ name }}:
  pkg.installed

{{ name }}-api:
  service.running:
    - enable: True
    - restart: True
    - require:
      - pkg: {{ name }}
      - file: /etc/{{ name }}/{{ name }}-api.conf
    - watch:
      - file: /etc/{{ name }}/{{ name }}-api.conf

{{ name }}-registry:
  service.running:
    - enable: True
    - restart: True
    - require:
      - pkg: {{ name }}
      - file: /etc/{{ name }}/{{ name }}-registry.conf
    - watch:
      - file: /etc/{{ name }}/{{ name }}-registry.conf

{{ name }}-sync-db:
  cmd.run:
    - name: {{ name }}-manage db_sync
    - user: glance
    - group: glance
    - require:
      - file: /etc/{{ name }}/{{ name }}-api.conf
      - file: /etc/{{ name }}/{{ name }}-registry.conf

/etc/{{ name }}/{{ name }}-api.conf:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/{{ name }}-api.conf
    - template: jinja
    - require:
      - pkg: {{ name }}

/etc/{{ name }}/{{ name }}-registry.conf:
  file.managed:
    - source: salt://software/openstack/{{ name }}/files/{{ name }}-registry.conf
    - template: jinja
    - require:
      - pkg: {{ name }}

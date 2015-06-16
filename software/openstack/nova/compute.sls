{%- set controller = salt['pillar.get']('openstack:controller','localhost') %}
{%- set name = "nova" %}
{%- set type = "compute" %}
{%- set packages = ['nova-compute','sysfsutils'] %}
{%- set services = ['nova-compute'] %}

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
      - file: /etc/{{ name }}/{{ name }}.conf
    - watch:
      - file: /etc/{{ name }}/{{ name }}.conf
      - file: /etc/{{ name }}/{{ name }}-compute.conf
{%- endfor %}

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

{% from "bind/map.jinja" import map with context %}

include:
  - bind.config

{% for zone, zone_data in salt['pillar.get']('bind:configured_zones', {}).iteritems() -%}
{%- set file = salt['pillar.get']("bind:available_zones:" + zone + ":file") %}
{% if file and zone_data['type'] == "master" -%}
zones-{{ zone }}-journal-clear:
  file.absent:
    - name: {{ map.named_directory }}/{{ file }}.jnl
    - onchanges:
      - file: zones-{{ zone }}
    - require_in:
      - service: bind
    - watch_in:
      - service: bind
{% endif -%}
{% endfor -%}

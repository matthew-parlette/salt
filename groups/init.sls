{%- for group in salt['pillar.get']('groups', []) %}
{{ group }}-group:
  group.present:
    - name: {{ group }}
    {%- if group == 'sudo' %}
    - system: True
    {%- endif %}
{%- endfor %}

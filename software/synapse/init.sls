synapse:
  {%- if grains['os'] == 'Ubuntu' and grains['osmajorrelease'] < 16 %}
  pkgrepo.managed:
    - ppa: synapse-core/ppa
  pkg.installed:
    - requre:
      - pkgrepo: synapse
  {%- else %}
  pkg.installed
  {%- endif %}

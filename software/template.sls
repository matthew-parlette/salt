{% set name = "package-name" %}
{% set packages = ['pkg1','pkg2'] %}
{% set ppa = None %}

{{ package }}:
  {% if ppa %}
  pkgrepo.managed:
    - ppa: {{ ppa }}
    - require_in:
      - pkg: {{ package }}
  {% endif %}
  pkg.latest:
    - pkgs:
      {% for package in packages %}
      - {{ package }}
      {% endfor %}
    - refresh: False

{% set name = "package-name" %}
{% set packages = ['pkg1','pkg2'] %}
{% set ppa = None %}

{{ name }}:
  {% if ppa %}
  pkgrepo.managed:
    - ppa: {{ ppa }}
    - require_in:
      - pkg: {{ name }}
  {% endif %}
  pkg.latest:
    - pkgs:
      {% for package in packages %}
      - {{ package }}
      {% endfor %}
    - refresh: False

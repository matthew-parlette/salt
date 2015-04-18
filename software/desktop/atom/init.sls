{% set name = "atom" %}
{% set packages = ['atom'] %}
{% set ppa = 'webupd8team/atom' %}

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

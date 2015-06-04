{% set user = "matt" %}
{% set path = "/home/matt/.config/pystromo" %}
{% set url  = "https://launchpad.net/pystromo/trunk/0.6.0/+download/pystromo-0.6.0.tar.gz" %}

{{ path }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

pystromo-archive:
  archive.extracted:
    - name: {{ path }}
    - source: {{ url }}
    - archive_user: {{ user }}
    - tar_options: xzf
    - require:
      - file: {{ path }}

pystromo-udev-rule:
  file.copy:
    - source: {{ path }}/config/52-pystromo-debian.rules
    - name: /etc/udev/rules.d/52-pystromo-debian.rules
    - require:
      - archive: pystromo-archive

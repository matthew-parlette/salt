{%- set motd_files = ['05-hostname'] %}
{%- set default_files = ['00-header','10-help-text','90-updates-available','91-release-upgrade','98-fsck-at-reboot','98-reboot-required'] %}
{%- set pkgs = ['figlet'] %}
{%- set path = '/etc/update-motd.d' %}

{%- for file in default_files %}
{{ path }}/{{ file }}:
  file.managed:
    - user: root
    - group: root
    - mode: 644
{%- endfor %}

{%- for file in motd_files %}
{{ path }}/{{ file }}:
  file.managed:
    - source: salt://motd/files/{{ file }}
    - template: jinja
    - user: root
    - group: root
    - mode: 755
{%- endfor %}

motd-packages:
  pkg.installed:
    - pkgs:
      {%- for pkg in pkgs %}
      - {{ pkg }}
      {%- endfor %}

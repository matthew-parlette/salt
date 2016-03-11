include:
  - software.nemo

{%- for user, settings in salt['pillar.get']('users', {}).items() %}
{{ user }}-disable-nemo-icons:
  module.run:
    - name: gnome.set
    - user: {{ user }}
    - schema: org.nemo.desktop
    - key: show-desktop-icons
    - value: "false"
    - require:
      - pkg: nemo
{%- endfor %}

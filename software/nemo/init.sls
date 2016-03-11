nemo:
  pkgrepo.managed:
    - ppa: webupd8team/nemo
  pkg.installed:
    - requre:
      - pkgrepo: nemo

{%- for user, settings in salt['pillar.get']('users', {}).items() %}
{{ user }}-disable-nautilus-icons:
  module.run:
    - name: gnome.set
    - user: {{ user }}
    - schema: org.gnome.desktop.background
    - key: show-desktop-icons
    - value: "false"
    - require:
      - pkg: nemo

{{ user }}-default-to-nemo:
  cmd.run:
    - name: xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
    - user: {{ user }}
    - require:
      - pkg: nemo
{%- endfor %}

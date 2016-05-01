{%- set users = salt['pillar.get']('chrome:remote-desktop:users', ['matt']) %}

chrome-remote-desktop-deps:
  pkg.installed:
    - pkgs:
      - xvfb
      - xbase-clients
      - python-psutil

chrome-remote-desktop:
  pkg.installed:
    - sources:
      - chrome-remote-desktop: http://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    - require:
      - pkg: chrome-remote-desktop-deps

{%- for user in users %}
chrome-remote-desktop-virtual-desktop-{{ user }}:
  file.managed:
    - name: /home/{{ user }}/.chrome-remote-desktop-session
    - user: {{ user }}
    - group: {{ user }}
    - contents: |
        #!/bin/bash
        exec /usr/sbin/lightdm-session "gnome-session --session=ubuntu"
{%- endfor %}

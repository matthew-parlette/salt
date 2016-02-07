include:
  - pip

i3:
  pkg.installed

compton:
  pkg.installed

{%- set user = "matt" %}
{%- set path = "/tmp/dex" %}

git:
  pkg.installed

sphinx:
  pip.installed

dex:
  ssh_known_hosts.present:
    - name: github.com
    - user: {{ user }}
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
    - enc: ssh-rsa
  git.latest:
    - name: git@github.com:jceb/dex.git
    - rev: master
    - user: {{ user }}
    - target: {{ path }}
    - require:
      - pkg: git
      - ssh_known_hosts: dex
      - file: {{ path }}
  cmd.run:
    - name: make;make install
    - user: {{ user }}
    - group: {{ user }}
    - cwd: {{ path }}
    - require:
      - git: dex
      - pip: sphinx

{{ path }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

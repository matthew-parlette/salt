zsh:
  pkg.installed

{%- for user in salt['pillar.get']('users',{}) %}
{%- if salt['pillar.get']('users:' + user + ':userinfo:shell', False) == '/bin/zsh' %}
oh-my-zsh-{{ user }}:
  cmd.script:
    - source: salt://shell/zsh/files/install.sh
    - user: {{ user }}
    - group: {{ user }}
    - creates: /home/{{ user }}/.oh-my-zsh
    - require:
      - pkg: zsh
{%- endif %}
{%- endfor %}

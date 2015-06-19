{% set user = "matt" %}
{% set dotfiles_path = "/home/matt/src/dotfiles" %}

dotfiles:
  ssh_known_hosts.present:
    - name: github.com
    - user: {{ user }}
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
    - enc: ssh-rsa
  git.latest:
    - name: git@github.com:matthew-parlette/dotfiles.git
    - rev: master
    - user: {{ user }}
    - target: {{ dotfiles_path }}
    - require:
      - ssh_known_hosts: dotfiles
      - file: {{ dotfiles_path }}
  cmd.run:
    - name: git submodule update --init --remote --force dotbot;./install
    - user: {{ user }}
    - group: {{ user }}
    - cwd: {{ dotfiles_path }}
    - require:
      - git: dotfiles

{{ dotfiles_path }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

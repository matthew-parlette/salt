include:
  - software.i3
  - software.i3.blocks

i3-gaps-prerequisites:
  pkg.installed:
    - pkgs:
      - libxcb1-dev
      - libxcb-keysyms1-dev
      - libpango1.0-dev
      - libxcb-util0-dev
      - libxcb-icccm4-dev
      - libyajl-dev
      - libstartup-notification0-dev
      - libxcb-randr0-dev
      - libev-dev
      - libxcb-cursor-dev
      - libxcb-xinerama0-dev

/tmp/src/i3:
  file.directory:
    - user: root
    - group: root
    - makedirs: True

i3-gaps:
  git.latest:
    - name: https://github.com/o4dev/i3.git
    - rev: gaps
    - user: root
    - target: /tmp/src/i3
    - require:
      - file: /tmp/src/i3
  cmd.run:
    - name: make && make install
    - user: root
    - group: root
    - cwd: /tmp/src/i3
    - require:
      - pkg: i3
      - git: i3-gaps


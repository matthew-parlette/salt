include:
  - software.i3

i3lock-blur-prerequisites:
  pkg.installed:
    - pkgs:
      - pkg-config
      - libxcb1-dev
      - libxcb1
      - libgl2ps-dev
      - libx11-dev
      - libglc0
      - libglc-dev
      - libcairo2-dev
      - libcairo-gobject2
      - libcairo2-dev
      - libxkbfile-dev
      - libxkbfile1
      - libxkbcommon-dev
      - libxkbcommon-x11-dev
      - libxcb-xkb-dev
      - libxcb-dpms0-dev
      - libxcb-damage0-dev
      - libpam0g-dev
      - libev-dev
      - libxcb-image0-dev
      - libxcb-util0-dev
      - libxcb-composite0-dev
      - libxcb-xinerama0-dev

/tmp/src/i3lock-blur:
  file.directory:
    - user: root
    - group: root
    - makedirs: True

i3lock-blur:
  git.latest:
    - name: https://github.com/karulont/i3lock-blur.git
    - rev: master
    - user: root
    - target: /tmp/src/i3lock-blur
    - require:
      - file: /tmp/src/i3lock-blur
  cmd.run:
    - name: make && make install
    - user: root
    - group: root
    - cwd: /tmp/src/i3lock-blur
    - require:
      - pkg: i3
      - git: i3lock-blur


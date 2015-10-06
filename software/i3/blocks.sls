include:
  - software.i3

# ruby-ronn for i3blocks
# acpi for i3blocks battery script
i3-blocks-prerequisites:
  pkg.installed:
    - pkgs:
      - ruby-ronn
      - acpi

/tmp/src/i3blocks:
  file.directory:
    - user: root
    - group: root
    - makedirs: True

i3-blocks:
  git.latest:
    - name: https://github.com/vivien/i3blocks
    - rev: master
    - user: root
    - target: /tmp/src/i3blocks
    - require:
      - file: /tmp/src/i3blocks
  cmd.run:
    - name: make && make install
    - user: root
    - group: root
    - cwd: /tmp/src/i3blocks
    - require:
      - pkg: i3
      - git: i3-blocks


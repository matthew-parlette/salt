include:
  - software.i3

dunst:
  pkg.purged:
    - require:
      - pkg: i3
  cmd.run:
    - name: killall dunst
    - onlyif: pgrep dunst
    - require:
      - pkg: dunst

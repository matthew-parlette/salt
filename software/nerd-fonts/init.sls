include:
  - git

nerd-fonts:
  git.latest:
    - name: https://github.com/ryanoasis/nerd-fonts.git
    - rev: 1.1.0
    - target: /tmp/nerd-fonts
    - require:
      - pkg: git
      - file: nerd-fonts
  cmd.run:
    - name: /tmp/nerd-fonts/install.sh
    - cwd: /tmp/nerd-fonts
    - onchanges:
      - git: nerd-fonts
  file.directory:
    - name: /tmp/nerd-fonts
    - makedirs: True

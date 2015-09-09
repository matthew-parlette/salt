npm:
  pkg.installed

node:
  pkg.absent

nodejs:
  pkg.installed

node-symlink:
  file.symlink:
    - name: /usr/bin/node
    - target: /usr/bin/nodejs
    - makedirs: True
    - user: root
    - group: root
    - require:
      - pkg: node
      - pkg: nodejs

hubble:
  npm.installed:
    - require:
      - pkg: npm
      - pkg: node
      - pkg: nodejs
      - file: node-symlink

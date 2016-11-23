include:
  - software.neofetch

/etc/update-motd.d:
  file.recurse:
    - source: salt://motd/files
    - template: jinja
    - user: root
    - group: root
    - file_mode: 755
    - clean: True

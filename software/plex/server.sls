include:
  - git

plexmediaserver:
  service.running:
    - watch:
      - cmd: plexupdate

plexupdate:
  git.latest:
    - name: https://github.com/mrworf/plexupdate.git
    - target: /tmp/plexupdate
    - require:
      - pkg: git
      - file: plexupdate
  cmd.run:
    - name: /tmp/plexupdate/plexupdate.sh -ad
    - cwd: /tmp/plexupdate
    - onchanges:
      - git: plexupdate
  file.directory:
    - name: /tmp/plexupdate
    - makedirs: True

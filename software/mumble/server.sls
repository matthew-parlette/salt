include:
  - software.mumble.repo

mumble-server:
  pkg.installed:
    - require:
      - pkgrepo: mumble-repo
  file.managed:
    - name: /etc/mumble-server.ini
    - source: salt://software/mumble/files/mumble-server.ini.jinja
    - user: root
    - password: root
    - mode: 640
    - template: jinja
    - require:
      - pkg: mumble-server
  service.running:
    - enable: True
    - watch:
      - file: mumble-server

anoise:
  pkgrepo.managed:
    - ppa: costales/anoise
  pkg.latest:
    - pkgs:
      - anoise
      - anoise-community-extension1
      - anoise-gui
    - refresh: False
    - require:
      - pkgrepo: anoise

include:
  - pip

croniter:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: dev-tools
      - cmd: get-pip

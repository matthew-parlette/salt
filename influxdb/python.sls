include:
  - pip

influxdb:
  pip.installed:
    - upgrade: True
    - require:
      - cmd: get-pip

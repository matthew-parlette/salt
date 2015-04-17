glances:
  pkg.latest:
    - name: python-pip
    - refresh: False
  pip.installed:
    - name: Glances
    - upgrade: True
    - require:
      - pkg: glances

python-pip:
  pkg.installed

python-dev:
  pkg.installed

glances:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: python-pip
      - pkg: python-dev

python-setuptools:
  pkg.installed

easy_install-pip:
  cmd.run:
    - name: easy_install pip
    - require:
      - pkg: python-setuptools

python-dev:
  pkg.installed

glances:
  pip.installed:
    - upgrade: True
    - require:
      - cmd: easy_install-pip
      - pkg: python-dev

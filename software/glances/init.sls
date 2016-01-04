python-setuptools:
  pkg.installed

easy_install-pip:
  cmd.run:
    - name: easy_install pip
    - require:
      - pkg: python-setuptools

python-psutil:
  pkg.purged:
    - require_in:
      - pip: glances

python-dev:
  pkg.installed

glances:
  pkg.purged:
    - require_in:
      - pip: glances
  pip.installed:
    - upgrade: True
    - require:
      - cmd: easy_install-pip
      - pkg: python-dev

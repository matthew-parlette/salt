include:
  - pip

# python-setuptools:
#   pkg.installed

# easy_install-pip:
#   cmd.run:
#     - name: easy_install pip
#     - require:
#       - pkg: python-setuptools

python-psutil:
  pkg.purged:
    - require_in:
      - pip: glances

python-dev:
  {%- if grains['os_family'] == 'Debian' %}
  pkg.installed:
  {%- elif grains['os_family'] == 'RedHat' %}
  pkg.installed:
    - name: python-devel
  {%- endif %}
    - require_in:
      - pip: glances

dev-tools:
  {%- if grains['os_family'] == 'Debian' %}
  pkg.installed:
    - name: build-essential
  {%- elif grains['os_family'] == 'RedHat' %}
  pkg.group_installed:
    - name: development tools
  {%- endif %}
    - require_in:
      - pip: glances

glances:
  pkg.purged:
    - require_in:
      - pip: glances
  pip.installed:
    - upgrade: True
    - require:
      # - pkg: python-dev
      - pkg: dev-tools
      - cmd: get-pip

include:
  - pip

docker-py:
  pip.installed:
    - require:
      - cmd: get-pip

include:
  - pip

kubernetes-python-client:
  pip.installed:
    - name: kubernetes
    - require:
      - cmd: get-pip

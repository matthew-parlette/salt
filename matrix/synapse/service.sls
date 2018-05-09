# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "matrix/synapse/map.jinja" import synapse with context %}

include:
  - matrix.synapse.install
  - matrix.synapse.config

synapse:
  service.running:
    - name: {{ synapse.service.name }}
    - enable: True
    - watch:
      - file: synapse-systemd-service
      - pip: synapse-pkg
      - file: synapse-config

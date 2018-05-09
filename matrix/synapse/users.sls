# -*- coding: utf-8 -*-
# vim: ft=sls
# TODO
{% from "matrix/synapse/map.jinja" import synapse with context %}

include:
  - matrix.synapse.install

synapse-user-{{ user }}:
  cmd.run:
    - name: {{ synapse.service.name }}
    - enable: True
    - watch:
      - file: synapse-systemd-service
      - pip: synapse-pkg

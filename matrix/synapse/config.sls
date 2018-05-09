# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "matrix/synapse/map.jinja" import synapse with context %}

synapse-config:
  file.managed:
    - name: {{ synapse.config }}
    - source: salt://matrix/synapse/files/homeserver.yaml.jinja
    - template: jinja
    - mode: 644
    - user: root
    - group: root

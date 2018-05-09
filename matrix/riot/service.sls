# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "matrix/riot/map.jinja" import riot with context %}

riot:
  service.running:
    - name: {{ riot.service.name }}
    - enable: True

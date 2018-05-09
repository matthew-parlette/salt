# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "matrix/riot/map.jinja" import riot with context %}

riot:
  pkgrepo.managed:
    - humanname: Riot IM
    - name: deb https://riot.im/packages/debian/ {{ salt['grains.get']('oscodename') }} main
    - file: /etc/apt/sources.list.d/matrix-riot-im.list
    - key_url: https://riot.im/packages/debian/repo-key.asc
  pkg.installed:
    - name: {{ riot.pkg }}
    - require:
      - pkgrepo: riot

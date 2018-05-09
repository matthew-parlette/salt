# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "matrix/synapse/map.jinja" import synapse with context %}

include:
  - pip

synapse-prereq:
  pkg.installed:
    - pkgs:
      - build-essential
      - python2.7-dev
      - libffi-dev
      - python-setuptools
      - sqlite3
      - libssl-dev
      - python-virtualenv
      - libjpeg-dev
      - libxslt1-dev
  pip.installed:
    - name: setuptools
    - require:
      - cmd: get-pip

synapse-pkg:
  pip.installed:
    - name: https://github.com/matrix-org/synapse/tarball/master
    - bin_env: /home/{{ synapse.user }}/.synapse
    - require:
      - cmd: get-pip
      - cmd: synapse-virtualenv
      - pkg: synapse-prereq
      - pip: synapse-prereq

synapse-user:
  user.present:
    - name: {{ synapse.user }}
    - shell: /bin/bash

synapse-virtualenv:
  cmd.run:
    - name: virtualenv -p python2.7 /home/{{ synapse.user }}/.synapse
    - unless: ls /home/{{ synapse.user }}/.synapse
    - runas: {{ synapse.user }}
    - require:
      - user: synapse-user

synapse-systemd-service:
  file.managed:
    - name: /etc/systemd/system/synapse.service
    - source: salt://matrix/synapse/files/synapse.service.jinja
    - template: jinja
    - context:
        config: {{ synapse.config }}
    - user: root
    - group: root

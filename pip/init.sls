get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - user: root
    - group: root
    - mode: 755
    - source: https://bootstrap.pypa.io/get-pip.py
    - source_hash: md5=fe348f492a4faf63572449a8baf37328
  cmd.run:
    - name: python /tmp/get-pip.py
    - user: root
    - require:
      - file: get-pip

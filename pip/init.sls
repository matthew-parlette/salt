get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - user: root
    - group: root
    - mode: 755
    - source: https://bootstrap.pypa.io/get-pip.py
    - source_hash: md5=8a0fa2bd9e5d762daaf56f32fb3f9b3e
  cmd.run:
    - name: python /tmp/get-pip.py
    - user: root
    - require:
      - file: get-pip

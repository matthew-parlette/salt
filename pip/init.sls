get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - user: root
    - group: root
    - mode: 755
    - source: salt://pip/files/get-pip.py
  cmd.run:
    - name: python /tmp/get-pip.py
    - user: root
    - require:
      - file: get-pip

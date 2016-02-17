install-salt:
  file.managed:
    - name: /tmp/install_salt.sh
    - mode: 755
    - source:
      - salt://bootstrap/files/install_salt.sh
  cmd.run:
    {%- if salt['pillar.get']('bootstrap:master', False) %}
    - name: /tmp/install_salt.sh -P
    {%- else %}
    - name: /tmp/install_salt.sh -P -M
    {%- endif %}
    - require:
      - file: install-salt

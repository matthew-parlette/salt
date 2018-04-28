helm:
  file.managed:
    - name: /tmp/get-helm.sh
    - source: https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get
    - skip_verify: True
    - user: root
    - group: root
    - mode: 775
  cmd.run:
    - name: /tmp/get-helm.sh
    - runas: root
    - creates: /usr/local/bin/helm
    - require:
      - file: helm

opentsdb:
  docker_image.present:
    - name: petergrace/opentsdb-docker
    - force: True
  file.directory:
    - name: {{ salt['pillar.get']('opentsdb:path', '/var/opentsdb') }}
  docker_container.running:
    - name: opentsdb
    - image: petergrace/opentsdb-docker
    - binds:
      - {{ salt['pillar.get']('opentsdb:path', '/var/opentsdb') }}:/data/hbase:rw
    - port_bindings:
      - {{ salt['pillar.get']('opentsdb:port', 4242) }}:4242
    # - environment:
      # - {{ env }}: {{ value|yaml_squote }}
    - require:
      - docker_image: opentsdb
      - file: opentsdb

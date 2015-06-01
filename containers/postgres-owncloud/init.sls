{% set hostvol        = '/media/storage/containers/postgres-owncloud/' + grains['id'] +'/var/lib/postgresql/data' %}

postgres-image:
  dockerng.image_present:
    - name: postgres

postgres-owncloud:
  dockerng.running:
    - image: postgres
    - environment:
      - POSTGRES_USER: owncloud
      - POSTGRES_PASSWORD: "{{ salt['pillar.get']('containers:postgresql:users:owncloud','postgres') }}"
    - binds:
      - {{ hostvol }}:/var/lib/postgresql/data
    - require:
      - file: {{ hostvol }}

{{ hostvol }}:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

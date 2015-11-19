minecraft-world-dir:
  file.directory:
    - name: {{ salt['pillar.get']('minecraft:server:path','/srv/minecraft-server') }}/world
    - user: minecraft
    - makedirs: True

minecraft-map-render-dir:
  file.directory:
    - name: {{ salt['pillar.get']('minecraft:map:render:path','/srv/minecraft-map-render') }}
    - user: minecraft
    - makedirs: True

davenonne/mapcrafter:
  dockerng.image_present

minecraft-map-render:
  dockerng.running:
    - name: minecraft-map-render
    - image: davenonne/mapcrafter
    - binds:
      - {{ salt['pillar.get']('minecraft:server:path','/srv/minecraft-server') }}/world:/world
      - {{ salt['pillar.get']('minecraft:map:render:path','/srv/minecraft-map-render') }}:/www
    - require:
      - file: minecraft-world-dir
      - file: minecraft-map-render-dir
      - dockerng: davenonne/mapcrafter

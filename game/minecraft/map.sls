minecraft-map-render-dir:
  file.directory:
    - name: {{ salt['pillar.get']('minecraft:map:render:path','/srv/minecraft-map-render') }}
    - user: minecraft
    - makedirs: True

nginx:
  dockerng.image_present

minecraft-map-host:
  dockerng.running:
    - name: minecraft-map-host
    - image: nginx
    - port_bindings:
      - 8001:80
    - binds:
      - {{ salt['pillar.get']('minecraft:map:render:path','/srv/minecraft-map-render') }}:/usr/share/nginx/html:ro
    - require:
      - file: minecraft-map-render-dir
      - dockerng: nginx

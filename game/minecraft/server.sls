# docker-py:
#   pip.installed:
#     - require:
#       - pkg: python-pip

minecraft-server-dir:
  file.directory:
    - name: {{ salt['pillar.get']('minecraft:server:path','/srv/minecraft-server') }}
    - user: minecraft
    - makedirs: True

itzg/minecraft-server:
  dockerng.image_present

minecraft-server:
  dockerng.running:
    - name: minecraft-server
    - image: itzg/minecraft-server
    - port_bindings:
      - 25565:25565
    - binds:
      - /media/storage/games/minecraft-server:/data
    - environment:
      - EULA: 'TRUE'
      - OPS: {{ salt['pillar.get']('minecraft:server:ops','')|yaml_squote }}
      - MODE: {{ salt['pillar.get']('minecraft:server:mode','survival')|yaml_squote }}
      - MOTD: {{ salt['pillar.get']('minecraft:server:motd','Welcome!')|yaml_squote }}
      - PVP: {{ salt['pillar.get']('minecraft:server:pvp','true')|yaml_squote }}
      - VERSION: {{ salt['pillar.get']('minecraft:server:version','LATEST')|yaml_squote }}
      - UID: {{ salt['pillar.get']('minecraft:server:uid','1000')|yaml_squote }}
    - require:
      - file: minecraft-server-dir
      - dockerng: itzg/minecraft-server

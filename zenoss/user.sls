zenoss:
  group.present:
    - gid: 1206
  user.present:
    - uid: 1337
    - fullname: zenoss
    - shell: /bin/bash
    - createhome: True
    - home: /home/zenoss
    - gid: 1206
    - groups:
      - zenoss
    - require:
      - group: zenoss

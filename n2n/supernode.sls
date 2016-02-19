include:
  - n2n

supernode:
  user.present:
    - home: /tmp
    - createhome: False
    - shell: /dev/null
  file.managed:
    - name: /etc/init/supernode.conf
    - user: root
    - group: root
    - source: salt://n2n/files/supernode.conf.jinja
    - template: jinja
{%- if grains['host'] in salt['pillar.get']('n2n:hosts',{}) %}
    - context:
        n2n: {{ salt['pillar.get']('n2n',{}) }}
        ip: {{ salt['pillar.get']('n2n:hosts:' + grains['host'],'') }}
{%- endif %}
  service.running:
    - name: supernode
    - enable: True
    - reload: True
    - require:
      - file: supernode
      - pkg: n2n
    - watch:
      - file: supernode

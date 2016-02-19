include:
  - n2n

node:
  file.managed:
    {%- if salt['grains.get']('osrelease_info', [14, 4])[0] < 15 %}
    - name: /etc/init/n2n.conf
    - source: salt://n2n/files/n2n.conf.jinja
    {%- else %}
    - name: /lib/systemd/system/n2n.service
    - source: salt://n2n/files/n2n.service.jinja
    {%- endif %}
    - template: jinja
{%- if grains['host'] in salt['pillar.get']('n2n:hosts',{}) %}
    - context:
        n2n: {{ salt['pillar.get']('n2n',{}) }}
        ip: {{ salt['pillar.get']('n2n:hosts:' + grains['host'],'') }}
{%- endif %}
  service.running:
    - name: n2n
    - enable: True
    - require:
      - file: node
      - pkg: n2n
    - watch:
      - file: node

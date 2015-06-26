{%- set users = salt['pillar.get']('netrc',[]) %}

{%- for user in users %}
netrc-{{ user }}:
  file.managed:
    - name: /home/{{ user }}/.netrc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - contents_pillar: netrc:{{ user }}
{%- endfor %}

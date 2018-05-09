gcloud:
  archive.extracted:
    - name: /opt
    - source: {{ salt['pillar.get']('gcloud:download:url') }}
    - source_hash: {{ salt['pillar.get']('gcloud:download:url_hash') }}
    - user: root
    - group: root

{%- for project, values in salt['pillar.get']('gcloud:projects', {}).iteritems() %}
{%- for user, user_settings in salt['pillar.get']('gcloud:projects:' + project + ':keys:users', {}).iteritems() %}
gcloud-key-{{ user }}:
  file.managed:
    - name: /etc/gcloud/keys/{{ user }}.json
    - makedirs: True
    - source: salt://gcloud/files/key.json.jinja
    - template: jinja
    - context:
        project: {{ project }}
        user: {{ user }}
    - user: root
    - group: root
    - mode: 600

gcloud-auth-{{ user }}:
  cmd.run:
    - name: /opt/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=/etc/gcloud/keys/{{ user }}.json
    - user: root
    - group: root
    - require:
      - file: gcloud-key-{{ user }}
    - unless: '/opt/google-cloud-sdk/bin/gcloud auth list 2>&1|grep dns-admin'
{%- endfor %}
{%- endfor %}

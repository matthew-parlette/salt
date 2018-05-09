{%- for name, database in salt['pillar.get']('influxdb:server:database', {}).iteritems() %}
database-{{ name }}:
  influxdb_database.present:
    - name: {{ database.get('name') }}

{%- for rp in database.get('retention_policy', []) %}
retention-policy-{{ rp.get('name') }}:
  influxdb_retention_policy.present:
    - name: {{ rp.get('name') }}
    - database: {{ database.get('name') }}
    - duration: {{ rp.get('duration', '7d') }}
    - replication: {{ rp.get('replication', 1) }}
    - default: {{ rp.get('default', 'false') }}
    - require:
      - influxdb_database: database-{{ name }}
{%- endfor %}
{%- endfor %}

{%- for name, user in salt['pillar.get']('influxdb:server:user', {}).iteritems() %}
user-{{ name }}:
  influxdb_user.present:
    - name: {{ user.get('name') }}
    - password: {{ user.get('password') }}
    - admin: {{ user.get('admin', 'false') }}
    - grants:
        {%- for grant_name, grant in salt['pillar.get']('influxdb:server:grant', {}).iteritems() %}
        {%- if grant.get('user', '') == user.get('name') %}
        {{ grant.get('database') }}: {{ grant.get('privilege') }}
        {%- endif %}
        {%- endfor %}
{%- endfor %}

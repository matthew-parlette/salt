{%- set secrets = salt['pillar.get']('kubernetes:secrets:media', []) %}
{%- for secret in secrets %}
media-secret-{{ secret.get('name') }}:
  kubernetes.secret_present:
    - name: {{ secret.get('name') }}
      namespace: {{ secret.get('namespace', 'default') }}
      data:
        {%- for key, value in secret.get('data', {}).iteritems() %}
        {{ key }}: {{ value }}
        {%- endfor %}
{%- endfor %}

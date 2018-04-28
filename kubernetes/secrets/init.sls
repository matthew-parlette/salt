{%- for secret in salt['pillar.get']('kubernetes:secrets', []) %}
secret-{{ secret.get('name') }}:
  kubernetes.secret_present:
    - name: {{ secret.get('name') }}
      namespace: {{ secret.get('namespace', 'default') }}
      data:
        {%- for key, value in secret.get('data', {}).iteritems() %}
        {{ key }}: {{ value }}
        {%- endfor %}
{%- endfor %}

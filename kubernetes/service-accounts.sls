service-account-directory:
  file.directory:
    - name: /opt/k8s
    - mode: 755

{%- for account in salt['pillar.get']('kubernetes:service-accounts', []) %}
service-account-{{ account.get('metadata', {}).get('name') }}:
  file.managed:
    - name: /opt/k8s/service-account-{{ account.get('metadata', {}).get('name') }}.yaml
    - makedirs: True
    - contents: {{ account|yaml(False)|yaml_dquote }}
  cmd.wait:
    - name: kubectl create -f /opt/k8s/service-account-{{ account.get('metadata', {}).get('name') }}.yaml
    - require:
      - file: service-account-{{ account.get('metadata', {}).get('name') }}
{%- endfor %}

{%- for ingress in salt['pillar.get']('kubernetes:ingresses', []) %}
ingress-{{ ingress.get('metadata', {}).get('name') }}:
  file.managed:
    - name: /opt/k8s/ingress-{{ ingress.get('metadata', {}).get('name') }}.yaml
    - makedirs: True
    - contents: {{ ingress|yaml(False)|yaml_dquote }}
  cmd.wait:
    - name: kubectl create -f /opt/k8s/ingress-{{ ingress.get('metadata', {}).get('name') }}.yaml
    - require:
      - file: ingress-{{ ingress.get('metadata', {}).get('name') }}
{%- endfor %}

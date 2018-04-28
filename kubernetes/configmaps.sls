{%- for name, configmap in salt['pillar.get']('kubernetes:configmaps', {}).iteritems() %}
configmap-{{ name }}:
  file.managed:
    - name: /opt/k8s/configmap-{{ name }}.yaml
    - makedirs: True
    - contents: {{ configmap|yaml(False)|yaml_dquote }}
  cmd.wait:
    - name: kubectl create -f /opt/k8s/configmap-{{ name }}.yaml
    - require:
      - file: configmap-{{ name }}
{%- endfor %}

{%- for user in salt['pillar.get']('kubernetes:kubeconfig-users', []) %}
kubeconfig-{{ user }}:
  file.managed:
    - name: /home/{{ user }}/.kube/config
    - contents: {{ salt['pillar.get']('kubernetes:kubeconfig', {})|yaml(False)|yaml_dquote }}
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
{%- endfor %}

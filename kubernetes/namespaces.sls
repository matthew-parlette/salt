{%- for namespace in salt['pillar.get']('kubernetes:namespaces', []) %}
namespace-{{ namespace }}:
  kubernetes.namespace_present:
    - name: {{ namespace }}
{%- endfor %}

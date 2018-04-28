{%- for pod, values in salt['pillar.get']('kubernetes:pods', {}).iteritems() %}
{{ pod }}-pod:
  kubernetes.pod_present:
    name: 
    namespace: {{ salt['pillar.get']('kubernetes:pods:' + pod + ':namespace', 'default') }}
    metadata: 
{%- endfor %}

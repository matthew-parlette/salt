{%- for name, service in salt['pillar.get']('kubernetes:services', {}).iteritems() %}
service-{{ name }}:
  kubernetes.service_present:
    - name: {{ name }}
    - namespace: {{ service.get('namespace', 'default') }}
    - metadata: {{ service.get('metadata', {}) }}
    - spec: {{ service.get('spec', {}) }}
{%- endfor %}

{%- for name, deployment in salt['pillar.get']('kubernetes:deployments', {}).iteritems() %}
deployment-{{ name }}:
  kubernetes.deployment_present:
    - namespace: {{ deployment.get('namespace', 'default') }}
      metadata: {{ deployment.get('metadata', {}) }}
      spec: {{ deployment.get('spec', {}) }}
{%- endfor %}

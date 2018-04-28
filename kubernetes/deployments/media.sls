{%- set deployment = salt['pillar.get']('kubernetes:deployments:media', {}) %}
media-deployment:
  kubernetes.deployment_present:
    - namespace: {{ deployment.get('namespace', 'default') }}
      metadata: {{ deployment.get('metadata', {}) }}
      spec:
        replicas: {{ deployment.get('spec', {}).get('replicas', 1) }}
        template:
          metadata:
            labels:
              app: plex
          spec:
            {%- if deployment.get('spec', {}).get('containers', None) %}
            containers:
            {%- for name, container in deployment.get('spec', {}).get('containers', {}).iteritems() %}
            - name: {{ container.get('name') }}
              image: {{ container.get('image') }}
              {%- if container.get('mounts', None) %}
              volumeMounts:
              {%- for path, details in container.get('mounts', {}).iteritems() %}
              - mountPath: {{ path }}
                name: {{ details.get('name', '') }}
                readOnly: {{ details.get('read-only', 'false')|lower }}
              {%- endfor %}
              {%- endif %}
            {%- endfor %}
            {%- endif %}
            {%- if deployment.get('spec', {}).get('volumes', None) %}
            volumes:
            {%- for name, volume in deployment.get('spec', {}).get('volumes', {}).iteritems() %}
            - name: {{ volume.get('name') }}
              {%- if volume.get('cephfs', None) %}
              cephfs:
                monitors:
                  {%- for monitor in volume.get('cephfs', {}).get('monitors', []) %}
                  - {{ monitor }}
                  {%- endfor %}
                path: {{ volume.get('cephfs', {}).get('path', '/') }}
                user: {{ volume.get('cephfs', {}).get('user') }}
                secretRef:
                  name: {{ volume.get('cephfs', {}).get('secret-ref', {}).get('name') }}
                readOnly: {{ volume.get('cephfs', {}).get('read-only')|lower }}
              {%- endif %}
            {%- endfor %}
            {%- endif %}

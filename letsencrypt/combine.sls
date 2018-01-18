# For each domain, combine the fullchain and privkey for use with haproxy

{%- for domain, params in salt['pillar.get']('letsencrypt:client:domain', {}).iteritems() %}
combine-files-{{ domain }}:
  file.copy:
    - name: /etc/letsencrypt/live/{{ domain }}/fullchain-privkey.pem
    - source: /etc/letsencrypt/live/{{ domain }}/fullchain.pem
    - force: True
    - require:
      - cmd: certbot_{{ domain }}
  cmd.run:
    - name: cat /etc/letsencrypt/live/{{ domain }}/privkey.pem >> /etc/letsencrypt/live/{{ domain }}/fullchain-privkey.pem
    - require:
      - file: combine-files-{{ domain }}

symlink-ssl-cert-{{ domain }}:
  file.symlink:
    - name: /etc/ssl/private/{{ domain }}.pem
    - target: /etc/letsencrypt/live/{{ domain }}/fullchain-privkey.pem
    - makedirs: True
    - require:
      - cmd: combine-files-{{ domain }}
{%- endfor %}

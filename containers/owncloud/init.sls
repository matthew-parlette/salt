{% set name           = 'owncloud'   %}
{% set registryname   = 'mattparlette' %}
{% set tag            = 'latest' %}
{% set hostport       = '443' %}
{% set hostip         = '0.0.0.0' %}
{% set hostdata       = '/media/storage/owncloud/data' %}
{% set contdata       = '/var/www/owncloud/data' %}
{% set hostconf       = '/media/storage/owncloud/config' %}
{% set contconf       = '/var/www/owncloud/config' %}

mattparlette/owncloud:latest:
  dockerng.image_present

owncloud:
  dockerng.running:
    - image: mattparlette/owncloud:latest
    - environment:
      - SSL_KEY: "/root/ssl/cloud.matt.parlette.us.key"
      - SSL_CERT: "/root/ssl/cloud.matt.parlette.us.crt"
      - VIRTUAL_HOST: "cloud.matt.parlette.us"
    - binds:
      - /etc/pki/tls/certs/cloud.matt.parlette.us.key:/root/ssl/cloud.matt.parlette.us.key:ro
      - /etc/pki/tls/certs/cloud.matt.parlette.us.crt:/root/ssl/cloud.matt.parlette.us.crt:ro
      - {{ hostdata }}:{{ contdata }}
      - {{ hostconf }}:{{ contconf }}
    - port_bindings: "443:443"
    - links:
      - postgres-owncloud:db
    - require:
      - file: {{ hostdata }}
      - file: {{ hostconf }}

{{ hostdata }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{{ hostconf }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

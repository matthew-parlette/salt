# Insync only provides major release versions (precise, trusty)
{% set codename = 'trusty' if grains['oscodename'] in ['trusty','utopic','vivid'] else None %}
{%- if codename %}
insync:
  pkgrepo.managed:
    - humanname: Insync Repository
    - name: deb http://apt.insynchq.com/{{ grains['os'].lower()}} {{ codename }} non-free contrib
    - file: /etc/apt/sources.list.d/insync.{{ codename }}.list
    - key_url: https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key
    - gpgcheck: 1
  pkg.installed:
    - require:
      - pkgrepo: insync
{%- endif %}

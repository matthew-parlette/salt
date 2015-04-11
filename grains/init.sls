include:
  - salt.minion

/etc/salt/grains:
  file.managed:
    - template: jinja
    - source: salt://salt/files/grains
    - watch_in:
      - service: salt-minion

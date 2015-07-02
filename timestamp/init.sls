highstate-timestamp:
  file.touch:
    - name: /tmp/highstate.time
    - order: last

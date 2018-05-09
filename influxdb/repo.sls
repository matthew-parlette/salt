influxdb-repo:
  pkgrepo.managed:
    - humanname: InfluxDB
    - file: /etc/apt/sources.list.d/influxdb.list
    - name: deb https://repos.influxdata.com/ubuntu/ {{ salt['grains.get']('oscodename') }} stable
    - key_url: https://repos.influxdata.com/influxdb.key
    - refresh_db: True
    - watch_in:
      - pkg: influxdb_packages

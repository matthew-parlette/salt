grafana-repo:
  pkgrepo.managed:
    - humanname: Grafana
    - file: /etc/apt/sources.list.d/grafana.list
    # - name: deb https://packagecloud.io/grafana/stable/ubuntu/ {{ salt['grains.get']('oscodename') }} main
    - name: deb https://packagecloud.io/grafana/stable/debian/ stretch main
    - key_url: https://packagecloud.io/gpg.key
    - refresh_db: True
    - watch_in:
      - pkg: grafana_packages

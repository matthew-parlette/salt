ubuntu-cloud-keyring:
  pkg.installed

cloudarchive-kilo:
  pkgrepo.managed:
    - humanname: cloudarchive-kilo
    - name: deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main
    - file: /etc/apt/sources.list.d/cloudarchive-kilo.list
    - require:
      - pkg: ubuntu-cloud-keyring

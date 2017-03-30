insync:
  pkgrepo.managed:
    - humanname: Insync Repository
    - name: deb http://apt.insynchq.com/{{ grains['os'].lower()}} {{ grains['oscodename'] }} non-free contrib
    - file: /etc/apt/sources.list.d/insync.{{ grains['oscodename'] }}.list
    - key_url: https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key
    - gpgcheck: 1
  pkg.installed:
    - require:
      - pkgrepo: insync

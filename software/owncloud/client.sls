owncloud-client-repo:
  pkgrepo:
    - managed
    - name: deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_{{ salt['grains.get']('osrelease', '14.04') }}/ /
    - key_url: http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_{{ salt['grains.get']('osrelease', '14.04') }}/Release.key
    - file: /etc/apt/sources.list.d/owncloud-client.list
    - gpgcheck: 1
    - require_in:
      - pkg: owncloud-client

owncloud-client:
  pkg.latest

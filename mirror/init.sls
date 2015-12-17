mirror-packages:
  cmd.run:
    - name: apt-get update && apt-get upgrade
  pkg.installed:
    - pkgs:
      - apache2
      - apache2-doc
      - apache2-utils
      - libapache2-mod-php5
      - php5
      - php-pear
      - php5-xcache
      - chromium
      - x11-server-utils
      - unclutter
    - require:
      - cmd: mirror-packages

lxde-autostart:
  file.managed:
    - name: /etc/xdg/lxsession/LXDE-pl/autostart
    - contents: |
        @xscreensaver -no-splash
        @xset s off
        @xset -dpms
        @xset s noblank
        @chromium --kiosk --incognito http://localhost

mirror-www:
  git.latest:
    - name: https://github.com/matthew-parlette/magic-mirror.git
    - target: /var/www
    - user: www-data
    - force_clone: True
    - require:
      - pkg: mirror-packages

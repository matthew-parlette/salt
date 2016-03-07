mirror-packages:
  pkg.installed:
    - pkgs:
      - apache2
      - apache2-doc
      - apache2-utils
      - libapache2-mod-php5
      - php5
      - php-pear
      - php5-xcache
      - x11-utils
      - unclutter

chromium:
{% if grains['osarch'] == 'armhf' %}
  pkg.installed:
    - sources:
      - chromium-codecs-ffmpeg-extra: https://dl.dropboxusercontent.com/u/87113035/chromium-codecs-ffmpeg-extra_45.0.2454.85-0ubuntu0.15.04.1.1181_armhf.deb
      - chromium-browser: https://dl.dropboxusercontent.com/u/87113035/chromium-browser_45.0.2454.85-0ubuntu0.15.04.1.1181_armhf.deb
      - chromium-browser-l10n: https://dl.dropboxusercontent.com/u/87113035/chromium-browser-l10n_45.0.2454.85-0ubuntu0.15.04.1.1181_all.deb
{% elif grains['os'] == 'Ubuntu' %}
  pkg.installed:
    - name: chromium-browser
{% endif %}

/var/www/html:
  file.directory:
    - user: www-data
    - group: www-data
    - clean: True
    - require:
      - pkg: mirror-packages

mirror-www:
  git.latest:
    - name: https://github.com/matthew-parlette/magic-mirror.git
    - target: /var/www/html
    - user: www-data
    - require:
      - pkg: mirror-packages
      - file: /var/www/html

weather-config:
  file.managed:
    - name: /var/www/html/js/config.weather.js
    - contents: |
        config.weather = {
            //units: metric or imperial
            params: {
                q: "{{ salt['pillar.get']('mirror:weather:q','Arnold, Maryland') }}",
                units: "{{ salt['pillar.get']('mirror:weather:units','imperial') }}",
                lang: "{{ salt['pillar.get']('mirror:weather:lang','en') }}",
                APPID: "{{ salt['pillar.get']('mirror:weather:APPID','') }}"
            },
        }
    - require:
      - git: mirror-www

travel-config:
  file.managed:
    - name: /var/www/html/js/config.travel.js
    - contents: |
        config.travel = {
            params: {
                origin: "{{ salt['pillar.get']('mirror:travel:origin','Maryland') }}",
                destinations: [
                    {%- for dest in salt['pillar.get']('mirror:travel:destinations', []) %}
                    "{{ dest }}",
                    {%- endfor %}
                ]
            },
            api: {
                key: "{{ salt['pillar.get']('mirror:travel:api:key','API-KEY-HERE') }}"
            }
        }
    - require:
      - git: mirror-www

# Ubuntu
{% if grains['os'] == 'Ubuntu' %}
/home/matt/.bash_login:
  file.managed:
    - user: matt
    - group: matt
    - contents: |
        chromium-browser --kiosk --incognito http://localhost
{% endif %}

# Raspberry Pi
{% if grains['osarch'] == 'armhf' %}
lxde-autostart:
  file.managed:
    - name: /etc/xdg/lxsession/LXDE-pi/autostart
    - contents: |
        @xscreensaver -no-splash
        @xset s off
        @xset -dpms
        @xset s noblank
        @chromium --kiosk --incognito http://localhost

boot-config-hdmi-hotplug:
  file.replace:
    - name: /boot/config.txt
    - flags:
      - MULTILINE
    - pattern: |
        ^[#]?hdmi_force_hotplug=.*$
    - repl: |
        hdmi_force_hotplug=1

boot-config-display-rotate:
  file.replace:
    - name: /boot/config.txt
    - append_if_not_found: True
    - flags:
      - MULTILINE
    - pattern: |
        ^[#]?display_rotate=.*$
    - repl: |
        display_rotate=1
{% endif %}

reboot:
  cron.present:
    - identifier: salt-cron-reboot
    - user: root
    - minute: 0
    - hour: '*/2'

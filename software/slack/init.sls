slack-desktop:
  pkg.installed:
    - sources:
      - slack-desktop: https://slack-ssb-updates.global.ssl.fastly.net/linux_releases/slack-desktop-1.2.5-amd64.deb

scudcloud:
  pkgrepo.managed:
    - ppa: rael-gc/scudcloud
  pkg.latest:
    - refresh: True
    - require:
      - pkgrepo: scudcloud

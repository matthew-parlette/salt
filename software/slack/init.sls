slack-desktop:
  pkg.installed:
    - sources:
      - slack-desktop: https://downloads.slack-edge.com/linux_releases/slack-desktop-2.0.2-amd64.deb

scudcloud:
  pkgrepo.managed:
    - ppa: rael-gc/scudcloud
  pkg.latest:
    - refresh: True
    - require:
      - pkgrepo: scudcloud

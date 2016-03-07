{% set vagrant_repo = "/home/matt/src/vagrant" %}

vagrant:
  pkg.installed:
    - sources:
      - vagrant: https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
  ssh_known_hosts.present:
    - name: bitbucket.org
    - user: matt
    - fingerprint: 97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40
    - enc: ssh-rsa
  git.latest:
    - name: git@bitbucket.org:matthew-parlette/vagrant.git
    - rev: master
    - user: matt
    - target: {{ vagrant_repo }}
    - require:
      - pkg: vagrant
      - ssh_known_hosts: vagrant
      - file: {{ vagrant_repo }}

{{ vagrant_repo }}:
  file.directory:
    - user: matt
    - group: matt
    - makedirs: True

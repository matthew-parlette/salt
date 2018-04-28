{% set vagrant_repo = "/home/matt/src/vagrant" %}

vagrant:
  pkg.installed:
    - sources:
      - vagrant: https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_x86_64.deb
  ssh_known_hosts.present:
    - name: bitbucket.org
    - user: matt
    - fingerprint: 97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40
    - fingerprint_hash_type: md5
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

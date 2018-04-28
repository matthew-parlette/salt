include:
  - docker

kubernetes:
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: deb http://apt.kubernetes.io/ kubernetes-{{ salt['grains.get']('oscodename', 'xenial') }} main
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - refresh_db: True
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl
    - require:
      - service: docker-service
      - pkgrepo: kubernetes

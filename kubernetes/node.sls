include:
  - kubernetes
  - kubernetes.repo

join-to-cluster:
  cmd.run:
    - name: "kubeadm join --token {{ salt['pillar.get']('kubernetes:bootstrap:token', '') }} {{ salt['pillar.get']('kubernetes:bootstrap:master:ip', '') }}:{{ salt['pillar.get']('kubernetes:bootstrap:master:port', '') }} --discovery-token-ca-cert-hash sha256:{{ salt['pillar.get']('kubernetes:bootstrap:hash', '') }}"
    - creates: /etc/kubernetes/kubelet.conf
    - require:
      - pkg: kubernetes

include:
  - kubernetes
  - kubernetes.repo

create-cluster:
  cmd.wait:
    - name: kubeadm init {%- if salt['pillar.get']('kubernetes:bootstrap:master:token-ttl', None) is defined %} --token-ttl {{ salt['pillar.get']('kubernetes:bootstrap:master:token-ttl') }}{%- endif %}{%- if salt['pillar.get']('kubernetes:bootstrap:master:pod-network-cidr', None) is defined %} --pod-network-cidr {{ salt['pillar.get']('kubernetes:bootstrap:master:pod-network-cidr') }}{%- endif %}
    - creates: /etc/kubernetes/admin.conf
    - require:
      - pkg: kubernetes

network-pod:
  sysctl.present:
    - name: net.bridge.bridge-nf-call-iptables
    - value: 1
  cmd.wait:
    - name: kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
    - require:
      - cmd: create-cluster
      - sysctl: network-pod

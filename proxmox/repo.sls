proxmox-enterprise:
  pkgrepo.absent:
    - name: /etc/apt/sources.list.d/pve-enterprise.list

proxmox-no-subscription:
  pkgrepo.managed:
    - humanname: Proxmox Community
    - name: deb http://download.proxmox.com/debian/pve stretch pve-no-subscription
    - file: /etc/apt/sources.list.d/pve-no-subscription.list
    - key_url: http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg
    - refresh_db: True

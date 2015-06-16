base-system:
  salt.state:
    - tgt: '*'
    - highstate: True

salt-orchestration:
  salt.state:
    - tgt: '*'
    - sls:
      - orchestration.salt

openstack-orchestration:
  salt.state:
    - tgt: '*'
    - sls:
      - orchestration.openstack

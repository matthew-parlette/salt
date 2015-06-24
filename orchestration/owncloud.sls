owncloud-database:
  salt.state:
    - tgt: 'role:owncloud-database'
    - tgt_type: grain
    - sls:
      - containers.postgres-owncloud

owncloud-server:
  salt.state:
    - tgt: 'role:owncloud-server'
    - tgt_type: grain
    - sls:
      - containers.owncloud
    - require:
      - salt: owncloud-database

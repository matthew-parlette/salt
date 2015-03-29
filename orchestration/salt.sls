salt-master:
  salt.state:
    - tgt: 'role:salt-master'
    - tgt_type: grain
    - sls:
      - salt.master

salt-minion:
  salt.state:
    - tgt: '*'
    - sls:
      - salt.minion
      - salt.pkgrepo
    - require:
      - salt: salt-master

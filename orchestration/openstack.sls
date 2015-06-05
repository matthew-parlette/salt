rabbitmq:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - rabbitmq

rabbitmq-config:
  salt.state:
    - tgt: 'role:openstack-controller'
    - sls:
      - rabbitmq.config
    - require:
      - salt: rabbitmq

mysql:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - mysql.server
      - mysql.python
  
mysql-databases:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - mysql.database
      - mysql.remove_test_database
    - require:
      - salt: mysql

mysql-users:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - mysql.user
    - require:
      - salt: mysql-databases

openstack-repo:
  salt.state:
    - tgt: 'role:openstack*'
    - tgt_type: grain
    - sls:
      - software.openstack.repo


rabbitmq:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - rabbitmq

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

keystone:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - keystone.openrc
      - keystone.server
      - keystone.client
      - keystone.keystone
    - require:
      - salt: openstack-repo

glance:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - software.openstack.glance
    - require:
      - salt: keystone

nova-controller:
  salt.state:
    - tgt: 'role:openstack-controller'
    - tgt_type: grain
    - sls:
      - software.openstack.nova.controller
    - require:
      - salt: keystone
      - salt: glance
      - salt: rabbitmq

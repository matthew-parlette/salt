Getting Started
===============

After installing salt-master, bootstrapping the salt-minion on the master, then you can clone this repository into `/srv/salt`.

There is one small config to be done in `/etc/salt/master`, add the salt formula to the gitfs_remotes section:

    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git

Then run the orchestration with:

    $ sudo ./orchestrate

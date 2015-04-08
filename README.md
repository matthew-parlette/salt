Getting Started
===============

After installing salt-master, bootstrapping the salt-minion on the master, then you can clone this repository into `/srv/salt`.

There is one small config to be done in `/etc/salt/master`, add the salt formula to the gitfs_remotes section:

    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git

You may also want to setup the roles for your devices, using the example under `nodes` in `pillar.example`

Then run the orchestration with:

    $ ./orchestrate

Upgrading an Existing Minion
============================

To find the versions of all minions:

    $ ./versions

For old minions, you can upgrade them with:

    $ sudo salt 'host' state.sls bootstrap

This won't return properly, but it should work, to confirm:

    $ ./versions

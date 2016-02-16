States
======

ddns
----

This state extends the [bind-forumla|https://github.com/saltstack-formulas/bind-formula] to clear journal files if a zone file changes.
If this does not happen, then the zone's journal file will be out of date and won't load, causing all DDNS updates to fail.

The state imports `bind.config`, so you only need to run this state:

    $ sudo salt-call state.sls bind.ddns

Process
=======

Updating a zone
---------------

Make changes to the zone file in `/srv/salt/bind/zones` and run the state:

    $ sudo salt-call state.sls bind.ddns

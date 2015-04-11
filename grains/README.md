Set the grains on a minion in the `/etc/salt/grains` files. For now, this will set:

* roles

To use, you can run the state:

    $ sudo salt 'minion-name' state.sls grains

Or run it from orchestration.

See pillar.example for pillar layout.

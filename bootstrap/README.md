Run the salt minion bootstrap on an existing node, this can be used to upgrade an existing minion:

From the master:

    $ sudo salt 'minion-name' state.sls bootstrap

From the minion:

    $ sudo salt-call state.sls bootstrap

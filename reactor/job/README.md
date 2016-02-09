return.sls
----------

Handle job return events.

### Highstate Failed

Call the notify state when a highstate failed, including the states in the highstate that caused the failure.

This all goes through pegasus, since having them execute on the client was causing a traceback on one of the minions.

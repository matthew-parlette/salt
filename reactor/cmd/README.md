## return.sls

Handle cmd return events.

### Examples
`cmd/<process>/return`

### Scenarios

### Command Returned

Call the slack notify state (`#notifications` only).

This all goes through pegasus, since having them execute on the client was causing a traceback on one of the minions.

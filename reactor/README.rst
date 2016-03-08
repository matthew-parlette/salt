=======
reactor
=======

Reactor_ states used by this salt master.

Defined Reactors
================

.. contents::
    :local:

``salt/job/*/ret/*``
--------------------

Watch for highstate jobs to return, if there are any failed states in the highstate run, then call the ``notify`` state.

``cmd/*/return``
----------------

For any commands that return, call ``notify.notifications`` to post to the slack ``#notifications`` channel

.. _Reactor: https://docs.saltstack.com/en/latest/topics/reactor/index.html

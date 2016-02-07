Overview
========

The notify state is used primarily in reactors, since I couldn't get pillar data in the reactor state.

Usage
=====

Testing from CLI
----------------

    $ sudo salt-call state.sls notify.slack 'pillar={message: cli test message}'

Overview
========

The notify state is used primarily in reactors, since I couldn't get pillar data in the reactor state.

There are two slack notifications:

* `slack`: Catch all for any notification coming in to the system, shows in `#notifications`
* `slack.network`: Specific network-related messages, shows in `#network`

Usage
=====

Testing from CLI
----------------

    $ sudo salt-call state.sls notify.slack 'pillar={message: cli test message}'

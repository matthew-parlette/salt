=========
timestamp
=========

Create a timestamp when highstate completes. This is currently used in i3blocks_ (highstate.sh_) to make sure highstate is not falling behind.

Available states
================

.. contents::
    :local:

``timestamp``
-------------

Touch ``/tmp/highstate.time`` so its modification time is the last time highstate ran on this minion.

.. _i3blocks: https://github.com/matthew-parlette/dotfiles/blob/master/i3blocks.conf
.. _highstate.sh: https://github.com/matthew-parlette/dotfiles/blob/master/i3/scripts/highstate.sh

==============
Custom Modules
==============

These are custom modules in use for this salt master.

Available Modules
=================

.. contents::
    :local:

``slack_notify.post_message``
-----------------------------

This is the only function that has changed (from the copy of the official `slack_notify` state.

It handles messages as a string or a list. If the message is a list, then it will become a multi-line message in slack.

Mentions are also supported as a parameter to this function, but should not have punctuation in the parameter. For example:

* channel
* everyone
* someuser

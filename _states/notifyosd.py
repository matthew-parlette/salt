# -*- coding: utf-8 -*-
'''
Create a notification with NotifyOSD
====================================

This state is useful for sending messages to desktops during state runs.

.. versionadded:: 2015.5.0

.. code-block:: yaml

    notify-message:
      notifyosd.notify:
        - title: 'State Complete'
        - message: 'This state was executed successfully.'
'''
import logging

# Set up logging
log = logging.getLogger(__name__)

def __virtual__():
    '''
    Only load if the notifyosd module is available in __salt__
    '''
    return 'notifyosd' if 'notifyosd.notify' in __salt__ else False


def notify(name,
           message,
           title=''):
    '''
    Send a notification to the desktop.

.. code-block:: yaml

    notify-message:
      notifyosd.notify:
        - title: 'State Complete'
        - message: 'This state was executed successfully.'

    The following parameters are required:

    name
        The unique name for this event.

    message
        The message that is to be sent to the notification.

    The following parameters are optional:

    title
        The title for the notification.
    '''
    ret = {'name': name,
           'changes': {},
           'result': False,
           'comment': ''}

    if __opts__['test']:
        ret['comment'] = 'The following message is to be sent to NotifyOSD: {0}'.format(message)
        ret['result'] = None
        return ret

    if not message:
        ret['comment'] = 'Notification message is missing: {0}'.format(message)
        return ret

    cmd = "notify-send {} {}".format(title, message)
    log.debug("command is {}".format(cmd))

    result = __salt__['cmd.run'](
        cmd=cmd,
    )

    if result:
        ret['result'] = True
        ret['comment'] = 'Sent notification: {0}'.format(name)
    else:
        ret['comment'] = 'Failed to send notification: {0}'.format(name)

    return ret

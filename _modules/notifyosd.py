# -*- coding: utf-8 -*-
'''
Module for creating NotifyOSD notifications
'''

# Import Python libs
from __future__ import absolute_import
import logging
import socket
import os
from subprocess import call, Popen, PIPE

log = logging.getLogger(__name__)

__virtualname__ = 'notifyosd'

try:
    import pynotify
    HAS_PYNOTIFY = True
except:
    HAS_PYNOTIFY = False

def __virtual__():
    '''
    Return virtual name of the module.

    :return: The virtual name of the module.
    '''
    try:
        import pynotify
        # call(['notify-send'])
        # log.debug("notify-send appears to be available")
    except OSError as e:
        if e.errno == os.errno.ENOENT:
            # file not found
            return (False, 'notify-send does not exist')
        else:
            # something went wrong running notify-send
            return (False, 'notify-send did not work')
    if HAS_PYNOTIFY:
        return __virtualname__
    else:
        return (False, 'pynotify is not available')
    return __virtualname__


def notify(message,
           title=''):
    '''
    Create a NotifyOSD notification.

    :param title:       Title for the notification.
    :param message:     Notification message body.
    :return:            Boolean if message was sent successfully.

    CLI Example:

    .. code-block:: bash

        salt '*' notifyosd.notify title="Build complete" message="Build
        has completed in 24m"

    '''

    result = {}

    if not message:
        log.error('message is a required option.')

    if isinstance(message, list):
        log.debug("Message is a list, converting...")
        message = '\n'.join(message)
    log.debug("Message is {}".format(message))
    result['message'] = message

    # cmd = ['su', '-', 'matt', '-c', 'notify-send', title, message]
    # result['cmd'] = cmd
    # result['test'] = Popen(['grep -zi DBUS /proc/$(pgrep ^i3\$)/environ',
    #                         '|', 'sed -r -e s/^DBUS_SESSION_BUS_ADDRESS=//']
    #                        ).communicate()[0]
    # result['test'] = Popen(['pgrep', '^i3\$']).communicate()[0]
    # env = {
    #     'PATH': '/usr/bin',
    #     'DBUS_SESSION_BUS_ADDRESS': ''}
    # log.debug("Environment set to {}".format(str(env)))
    # result['env'] = env

    os.environ['DISPLAY'] = ':0.0'

    try:
        pynotify.init("saltstack")
        notification = pynotify.Notification(title, message)
        notification.show()

        # log.debug("Calling notify-send on {}".format(socket.gethostname()))
        # p = Popen(cmd, stdout=PIPE, stderr=PIPE)
        # result['stdout'], result['stderr'] = p.communicate()
        # result['return'] = p.returncode
    except Exception as e:
        log.error("Exception in Popen:\n{}".format(str(e)))
        return False
    return result

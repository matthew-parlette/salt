# -*- coding: utf-8 -*-
'''
Watch for git repos that have uncommitted changes, then fire an event.

.. author:: matthew.parlette@gmail.com
'''

# Import python libs
from __future__ import absolute_import, unicode_literals

import logging
import os

__virtualname__ = 'git'

log = logging.getLogger(__name__)


def __virtual__():
    '''
    Only load if git module is loaded
    '''
    return __virtualname__ if 'git.status' in __salt__ else False

def validate(config):
    '''
    Validate the beacon configuration
    '''
    # Configuration for git beacon should be a list
    if not isinstance(config, list):
        return False, ('Configuration for git beacon must be a list.')

    # Configuration for git beacon should contain paths
    paths_found = False
    paths_not_list = False
    for config_item in config:
        if 'paths' in config_item:
            paths_found = True
            if isinstance(config_item['paths'], list):
                paths_not_list = True

    if not paths_found or not paths_not_list:
        return False, 'Configuration for git beacon requires list of paths.'
    return True, 'Valid beacon configuration'


def beacon(config):
    '''
    Check if there are uncommitted or untracked changes in each path.

    .. code-block:: yaml

        beacons:
          git:
            - paths:
                - /home/user/src
                - /srv
    '''
    ret = []

    paths = config['paths']

    for top_level in paths:
        for path, dirnames, filenames in os.walk(top_level):
            if not path.endswith('.git'): continue
            path = path.replace('/.git', '')
            log.debug("Found git path: {}".format(path))
            _status = __salt__['git.status'](path)
            if "modified" in _status or "untracked" in _status:
                ret.append({'path': path,
                            'modified': _status['modified'] if "modified" in _status else [],
                            'untracked': _status['untracked'] if "untracked" in _status else []})
    log.debug("Emitting {}".format(str(ret)))
    return ret

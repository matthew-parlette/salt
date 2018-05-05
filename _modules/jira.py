# -*- coding: utf-8 -*-
'''
Module for interacting with jira issues

.. versionadded:: x

:configuration: This module can be used by either passing an api key and version
    directly or by specifying both in a configuration profile in the salt
    master/minion config.

    For example:

    .. code-block:: yaml

        jira.host: http://jira.example.com
        jira.username: admin
        jira.password: admin
'''

# Import Python libs
from __future__ import absolute_import
import logging

# Import 3rd-party libs
# pylint: disable=import-error,no-name-in-module,redefined-builtin
from salt.ext.six.moves.urllib.parse import urljoin as _urljoin
from salt.ext.six.moves.urllib.parse import urlencode as _urlencode
from salt.ext.six.moves import range
import salt.ext.six.moves.http_client
# pylint: enable=import-error,no-name-in-module

try:
    from jira import JIRA
    HAS_LIBS = True
except ImportError:
    HAS_LIBS = False

log = logging.getLogger(__name__)

__virtualname__ = 'jira'


def __virtual__():
    '''
    Return virtual name of the module.

    :return: The virtual name of the module.
    '''
    if HAS_LIBS:
        return __virtualname__
    return False, 'python jira library not found'


def _login(host, username, password):
    """

    """
    hostname = host or __salt__['config.option']('jira.host')
    if not hostname.startswith("http"): hostname = "http://{}".format(hostname)
    return JIRA(server=hostname, basic_auth=(username or __salt__['config.option']('jira.username'),
                                             password or __salt__['config.option']('jira.password')))


def _issues(open=True, closed=False, ignore_project=[], host=None, username=None, password=None):
    """
    Return issues found via search
    """
    api = _login(host, username, password)
    resolution = []
    if open: resolution.append("Unresolved")
    if closed:
        resolution.append("Done")
        resolution.append("Won't Do")
    search = []
    if resolution: search.append("resolution in ({})".format(",".join(resolution)))
    for ignore in ignore_project:
        search.append("project != {}".format(ignore))
    log.debug("Searching for existing issues with search term '{}'...".format(" AND ".join(search)))
    return api.search_issues("{}".format(" AND ".join(search)))

def issues(include_closed=False, ignore_project=[], host=None, username=None, password=None):
    '''
    List all open issues. Optionally include closed issues with closed=True

    :param closed: Include closed issues?
    :param host: JIRA instance URL
    :param username: JIRA username
    :param password: JIRA password
    :return: A list of all issues

    CLI Example:

    .. code-block:: bash

        salt '*' jira.issues

        salt '*' jira.issues include_closed=True
    '''
    issues = _issues(open=True, closed=False, ignore_project=ignore_project)
    log.debug("Returning {} issues: {}".format(len(issues),issues))
    return issues # ["{}: {}".format(issue.key, issue.fields.summary) for issue in issues]

def projects(host=None, username=None, password=None):
    '''
    List all projects.

    :param host: JIRA instance URL
    :param username: JIRA username
    :param password: JIRA password
    :return: A list of all projects

    CLI Example:

    .. code-block:: bash

        salt '*' jira.projects

        salt '*' jira.projects username=admin password=admin
    '''
    api = _login(host, username, password)
    return ["{}: {}".format(project.key, project.name) for project in api.projects()]

def create(summary, project, description="", issue_type="Task", priority="Medium",
           comment_if_exists=True, force=False, ignore_project=[],
           host=None, username=None, password=None):
    """
    Create an issue if it doesn't already exist. If force is provided, then an issue will be created regardless of the search.

    :param summary: Summary for the new issue
    :param project: Project key to create new issue in
    :param description: Description to use for new issue. This will be the comment added if the issue exists
    :param issue_type: Issue type (Task, Bug)
    :param priority: Name of the priority (Lowest, Low, Medium, High, Highest)
    :param comment_if_exists: Put the summary as a new comment if the issue already exists
    :param force: Create a new issue even if one already exists
    :param host: JIRA instance URL
    :param username: JIRA username
    :param password: JIRA password

    CLI Example:

    .. code-block:: bash

        salt '*' jira.create summary="test summary" project="PROJ" username=admin password=admin
    """
    api = _login(host, username, password)
    exists = []
    all_issues = issues(include_closed=False, ignore_project=ignore_project)
    for issue in all_issues:
        log.debug("Found issue {} with summary {}".format(issue.key, unicode(issue.fields.summary)))
    exists = [issue for issue in all_issues
              if unicode(issue.fields.summary) == unicode(summary)]
    if exists and not force:
        if comment_if_exists:
            log.debug("Found existing issue, adding comment...")
            for issue in exists:
                api.add_comment(issue, "I found another instance of this:\n\n{quote}{}{quote}".format(description, quote="{quote}"))
            return "Added comment to issues: {}".format(", ".join([issue.key for issue in exists]))
        else:
            log.info("Found existing issue, moving on...")
    else:
        log.debug("No existing issue found or force is True (force is {})".format(force))
        new = api.create_issue(project=project, summary=summary, description=description, issuetype={'name': issue_type}, priority={'name': priority})
        return "Created {}: {}".format(new.key, new.fields.summary)

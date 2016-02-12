include:
  - notify.slack

notify-slack-notifications:
  slack.post_message:
    - channel: "notifications"
    # - mention: '@channel'
    - from_name: {{ salt['pillar.get']('from', salt['grains.get']('id', 'Unknown')) }}
    - message: {{ salt['pillar.get']('message', ['No message provided']) }}

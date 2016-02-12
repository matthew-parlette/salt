include:
  - notify.slack

notify-slack-network:
  slack.post_message:
    - channel: "network"
    - from_name: {{ salt['pillar.get']('from', salt['grains.get']('id', 'Unknown')) }}
    - message: {{ salt['pillar.get']('message', ['No message provided']) }}

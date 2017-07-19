mattermost-notify-saltstack:
  module.run:
    - name: mattermost.post_message
    - api_url: {{ salt['pillar.get']('mattermost:team:admin:api_url') }}
    - hook: {{ salt['pillar.get']('mattermost:team:admin:hook') }}
    - channel: {{ salt['pillar.get']('mattermost:channel:saltstack:channel') }}
    - username: {{ salt['grains.get']('id', 'saltstack') }}
    - message: {{ salt['pillar.get']('message', ['No message provided'])|join(' ')|quote }}

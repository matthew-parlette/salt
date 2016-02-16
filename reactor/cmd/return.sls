notify:
  local.state.sls:
    - tgt: pegasus
#     - tgt: {{ data['id'] }}
    - arg:
      - notify.slack.notifications
    - kwarg:
        pillar:
          from: {{ data['id'] }}
          message:
            - '`{{ data['data']['process'] }}` has completed'

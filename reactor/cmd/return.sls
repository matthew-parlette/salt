{%- set blacklist = salt['pillar.get']('reactor:cmd:return:blacklist', ['vim']) %}
{%- if 'process' in data['data'] and data['data']['process'] not in blacklist %}
{%- if 'duration' in data['data'] and data['data']['duration'] > 15 %}
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
            {%- if 'duration' in data['data'] %}
            - The process took {{ data['data']['duration'] }} seconds
            {%- endif %}
            {%- if 'result' in data['data'] %}
            - Return code was `{{ data['data']['result'] }}`
            {%- endif %}
{%- endif %}
{%- endif %}

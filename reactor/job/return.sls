{%- if data['fun'] == 'state.highstate' %}
{%- set failed_states = [] %}
{%- for state, result in data['return'].iteritems() %}
    {%- if not result['result'] %}
        {%- do failed_states.append(state.split('_|-')[1]) %}
    {%- endif %}
{%- endfor %}
{% if failed_states %}
notify-mattermost:
  local.state.sls:
    - tgt: {{ data['id'] }}
    - arg:
      - notify.mattermost.channel.saltstack
    - kwarg:
        pillar:
          message:
            - '{{ data['fun'] }} has failed:'
            - '{{ failed_states|join(', ') }}'
{%- endif %}
{%- endif %}

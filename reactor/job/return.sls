{%- if data['fun'] == 'state.highstate' %}
# Gather failing states
{%- set failed_states = [] %}
{%- for state, result in data['return'].iteritems() %}
    {%- if not result['result'] %}
        {%- do failed_states.append(state) %}
    {%- endif %}
{%- endfor %}
{%- if failed_states %}
notify:
  local.state.sls:
    - tgt: {{ data['id'] }}
    - arg:
      - notify
    - kwarg:
        pillar:
          message: |
              {{ data['fun'] }} has failed!
# The following aborts the slack message
#               {%- if failed_states %}
#               Failing states:
#                   {%- for f in failed_states %}
#                   - {{ f }}
#                   {%- endfor %}
#               {%- endif %}
{%- endif %}
{%- endif %}

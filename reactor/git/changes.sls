changes-detected:
  local.jira.create:
    - tgt: {{ data['id'] }}
    - args:
      - summary: Push {{ data['path'] }} from {{ data['id'] }}
      - project: BACK
      - description: |
          Uncommitted changes detected in {{ data['path'] }}:
          
          h3. Modified

          {%- for item in data['modified'] %}
          * {{ item }}
          {%- endfor %}
          
          h3. Untracked

          {%- for item in data['untracked'] %}
          * {{ item }}
          {%- endfor %}
      - issue_type: Task
      - priority: Medium
      - ignore_project:
        - SAND

{%- if 'desktop' in salt['grains.get']('role', []) %}
notify-desktop:
  cmd.run:
    - name: notify-send {{ salt['pillar.get']('from', salt['grains.get']('id', 'Unknown'))|yaml_squote }} {{ salt['pillar.get']('message', ['No message provided'])|join(', ')|yaml_squote }}
{%- endif %}

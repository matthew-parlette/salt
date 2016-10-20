# To ensure the schedule is in effect, refresh the pillar
#  and restart the salt-minion

pillar-refresh:
  module.run:
    - name: saltutil.refresh_pillar

restart-minion:
  service.running:
    - name: salt-minion
    - watch:
      - module: pillar-refresh

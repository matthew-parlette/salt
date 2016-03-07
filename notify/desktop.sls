notify-desktop:
  notifyosd.notify:
    - title: '{{ salt['pillar.get']('from', salt['grains.get']('id', 'Unknown')) }}'
    - message: '{{ salt['pillar.get']('message', ['No message provided'])|join(', ') }}' 

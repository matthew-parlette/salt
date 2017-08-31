clean-docker-images:
  cmd.run:
    - name: docker volume rm $(docker volume ls -qf dangling=true)
    - unless: docker volume ls -qf dangling=true

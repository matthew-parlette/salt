clean-docker-images:
  cmd.run:
    - name: docker rmi $(docker images -q -f dangling=true)

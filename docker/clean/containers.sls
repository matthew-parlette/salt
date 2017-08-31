clean-docker-containers:
  cmd.run:
    - name: docker rm $(docker ps -aqf status=exited)
    - unless: docker ps -aqf status=exited

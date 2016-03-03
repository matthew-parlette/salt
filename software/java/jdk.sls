include:
  - software.java

oracle-java8-installer:
  cmd.run:
    - name: echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    - require:
      - pkgrepo: java
  pkg.installed:
    - requre:
      - cmd: oracle-java8-installer
      - pkgrepo: java

include:
  - software.mumble.repo

mumble-server:
  pkg.installed:
    - require:
      - pkgrepo: mumble-repo

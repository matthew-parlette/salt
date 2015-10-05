include:
  - software.mumble.repo

# This failed to authenticate, so force install
libavahi-compat-libdnssd1:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkgrepo: mumble-repo

mumble:
  pkg.installed:
    - require:
      - pkgrepo: mumble-repo
      - pkg: libavahi-compat-libdnssd1

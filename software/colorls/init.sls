include:
  - ruby.package
  - ruby.dev

# curses:
#   gem.installed

libncurses5-dev:
  pkg.installed

colorls:
  gem.installed:
    - require:
      - pkg: ruby
      - pkg: ruby-dev
      - pkg: libncurses5-dev

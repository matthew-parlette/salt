include:
{%- if salt['pillar.get']('ruby:install_from_source', False) %}
  - ruby
{%- else %}
  - ruby.package
  - ruby.dev
{%- endif %}

# curses:
#   gem.installed

libncurses5-dev:
  pkg.installed

colorls:
  gem.installed:
    - require:
      {%- if salt['pillar.get']('ruby:install_from_source', False) %}
      - cmd: ruby
      {%- else %}
      - pkg: ruby
      - pkg: ruby-dev
      {%- endif %}
      - pkg: libncurses5-dev

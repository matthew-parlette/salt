include:
  - node

yeoman:
  cmd.run:
    - name: npm install -g yo grunt-cli gulp-cli bower generator-angular-fullstack generator-react-fullstack
    - require:
      - pkg: nodejs.ppa

luzifer/mumble:
  dockerng.image_present

mumble:
  dockerng.running:
    - name: mumble-server
    - image: luzifer/mumble
    - port_bindings:
      - 64738:64738
    - require:
      - dockerng: luzifer/mumble

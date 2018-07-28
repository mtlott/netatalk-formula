{% from "netatalk/map.jinja" import netatalk with context %}

include:
  - netatalk

netatalk_config:
  file.managed:
    - name: {{ netatalk.config }}
    - source: {{ netatalk.config_src }}
    - template: jinja
    - watch_in:
      - service: netatalk

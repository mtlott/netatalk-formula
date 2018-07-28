{% from "netatalk/map.jinja" import netatalk with context %}

afppassword.conf:
{% if salt['file.file_exists' ]( netatalk.afppasswd ) %}
  file.exists:
    - name: {{ netatalk.afppasswd }}
{% else %}
  file.touch:
    - name: {{ netatalk.afppasswd }}
{% endif %}

{% for login,user in salt['pillar.get']('netatalk:users', {}).items() %}
{{ login }}:
  user.present:
    - fullname: {{ login }}
    - password: {{ user.password }}

afppasswd-{{ login }}:
  cmd.run:
    - name: "(echo '{{ user.password }}'; echo '{{ user.password }}') | afppasswd -a {{ login }}"
    - require:
      - file: {{ netatalk.afppasswd }}
{% endfor %}

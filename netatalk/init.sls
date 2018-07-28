{% from "netatalk/map.jinja" import netatalk with context %}

{% if grains.os not in ('MacOS', 'Windows',) %}

  {% if netatalk.preinstall.cmd %}
    {% if grains.osmajorrelease in netatalk.preinstall.osreleases %}

netatalk_preinstall_cmd:
  cmd.run:
    - name: {{ netatalk.preinstall.cmd }}
    - require_in: pkg.netatalk

    {% endif %}
  {% endif %}

  {% if netatalk.pkgrepo %}

netatalk_repo:
  pkgrepo.managed:
    - name: {{ netatalk.pkgrepo.name }}
    - humanname: {{ netatalk.pkgrepo.humanname }}
    - baseurl: {{ netatalk.pkgrepo.baseurl }}
    - gpgcheck: {{ netatalk.pkgrepo.gpgcheck }}
    - gpgkey: {{ netatalk.pkgrepo.gpgkey }}
    - skip_if_unavailable: {{ netatalk.pkgrepo.skip_if_unavailable }}
    - enabled: {{ netatalk.pkgrepo.enabled }}
    - repo_gpgcheck: {{ netatalk.pkgrepo.repo_gpgcheck }}
    - enabled_metadata: {{ netatalk.pkgrepo.enabled_metadata }}

  {% endif %}

avahi:
  pkg:
    - installed
    
netatalk:
  pkg.installed:
    - name: {{ netatalk.server }}
  {% if netatalk.pkgrepo %}
    - require:
      - pkgrepo: {{ netatalk.pkgrepo.name }}
  {% endif %}
  service.running:
    - name: {{ netatalk.service }}
    - enable: True
    - require:
      - pkg: netatalk

{% endif %}

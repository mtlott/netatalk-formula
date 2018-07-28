netatalk
=====
Install and configure a netatalk server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.
    
.. note::

    Some distros do not include netatalk so this formula allows the specification of a pkgrepo to pull the package. Specifically for Fedora 28 this formula pulls a built version from my public COPR repo. This is the only OS this has been tested on. Your results may vary. Pull requests accepted for anything you find. Enjoy!

Available states
================

.. contents::
    :local:
    
``netatalk``
---------

Installs the netatalk server package and service. Includes avahi as a prerequisite.

``netatalk.config``
----------------

Includes the ``netatalk`` state.

Creates a ``afp.conf`` based on defaults. Pillars if defined override default values.

``netatalk.users``
----------------

Includes the ``netatalk`` state.

Creates netatalk users (via ``afppasswd``)  based on pillar data.
Only use this if you require passwords managed by afppasswd.

Configuration
=============
The distro supplied netatalk package includes a default ``afp.conf`` which is overridden by ``netatalk.config`` state. This formula has good defaults for interoperability with samba, but can be extended/overridden in pillars.

User management is performed by the underlying OS through the password file.

See also: `Netatalk Documentation <http://netatalk.sourceforge.net/3.1/htmldocs/>`_.


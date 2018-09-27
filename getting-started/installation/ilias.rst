JSXC for Ilias
==============

.. warning::

    The Ilias version of JSXC is currently unmaintained.

Get the code
------------
Packed version
^^^^^^^^^^^^^^
Download the latest version from `releases <https://github.com/jsxc/jsxc.ilias/releases>`
and extract it to ``ILIAS_DIR/Customizing/global/plugins/Services/UIComponent/UserInterfaceHook/``.

Development version
^^^^^^^^^^^^^^^^^^^
    cd ILIAS_DIR/Customizing/global/plugins/Services/UIComponent/UserInterfaceHook/
    git clone https://github.com/sualko/jsxc.ilias ijsxc
    cd ijsxc
    git submodule update --init --recursive

Configuration
-------------
Rename ``config.inc.php.sample`` to ``config.inc.php`` and adjust the values for XMPP server,
BOSH url and XMPP domain and the values for WebRTC.

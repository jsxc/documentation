Screen Sharing
==============

Screen sharing is only supported by Chrome and Firefox (before version 52)
through a domain-specific extension. This means, that every domain which
tries to access the desktop needs to release his own extension. There
are example implementations for `Firefox <https://github.com/otalk/getScreenMedia/tree/master/firefox-extension-sample>`_
and `Chrome <https://github.com/otalk/getScreenMedia/tree/master/chrome-extension-sample>`_ which are easy to adapt.

Starting from version 52, Firefox doesn't require an extension
for screen sharing.

Screen sharing also requires an encrypted connection (https),
otherwise the browser will reject any screen media request.

.. Please don't forget to add the download url for your extension
    to ``jsxc.options.screenMediaExtension``. Otherwise no
    "Share screen" button will appear.

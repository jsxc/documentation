JSXC for Nextcloud
==================

.. warning::

    JSXC assumes that you are using the same credentials for your Nextcloud and XMPP server.

Requirements
------------
TODO

Get it
------
Go to your app store and enable the **JavaScript XMPP Client**.

Configure it
------------
Go to the Nextcloud admin page:

BOSH URL
    The URL to your bosh server (e.g. ``/http-bind/``). Please be aware of the same-origin-policy.
    If your XMPP server doesn't reside on the same host as your OwnCloud, use the Apache ProxyRequest
    as described in our `prepare Apache guide <https://github.com/jsxc/jsxc/wiki/Prepare-apache>`_.

XMPP domain
    The domain of your Jabber ID.

XMPP resource
    The resource of your JID. If you leaf this field blank a random resource is generated.

TURN url
    The url to your TURN server. You get a free account on http://numb.viagenie.ca

TURN username
    If no username is set, the TURN REST API is used.

TURN credential
    If no credential is set, the TURN REST API is used.</dd>

TURN secret
    Secret for TURN REST API.

TURN ttl
    Lifetime of credentials.

Internal JSXC XMPP server
-------------------------
    OJSXC implements a minimal XMPP server, just enough such that JSXC works.
    It is meant as a starting point, as long as you only run JSXC on Nextcloud.
    As soon as you require more features (external clients, server-to-server
    communications, ...) you should install a full-fledged XMPP server
    (they are pretty easy to install).

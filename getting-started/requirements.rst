Requirements
============
Obviously you need a running `web server <http://www.webdevelopersnotes.com/hosting/list_of_web_servers.php3>`_
and a `XMPP server <http://xmpp.org/xmpp-software/servers/>`_ with BOSH support.

Web server
----------

Apache
^^^^^^
If not already done, install apache on your Debian-based distribution::

    sudo apt install apache2

Enable the apache proxy module::

    sudo a2enmod proxy
    sudo a2enmod proxy_http

Add the proxy definition to your vhost configuration of your host-application
server (e.g. ``/etc/apache/sites-available/default``)::

    ProxyPass /http-bind/ http://localhost:5280/http-bind/
    ProxyPassReverse /http-bind/ http://localhost:5280/http-bind/

Reload apache configuration::

    sudo service apache2 reload

Finished!

Lighttpd
^^^^^^^^^^
Enable the ``mod_proxy`` module and add the proxy definition in
``/etc/lighttpd/lighttpd.conf``::

    server.modules += ( "mod_proxy" )
    proxy.server = (
        "/http-bind" => (
            ( "host" => "127.0.0.1", "port" => 5280 )
        )
    )

Here is an alternative example of a vhost config.

In the ``lighttpd.conf`` enable the `mod_proxy` module::

    server.modules = (
        ...
        "mod_proxy"
        ...
    )
    ...
    # include all files that are under vhosts
    include_shell "cat /etc/lighttpd/vhosts/*.conf"


and in ``vhosts/cloud.myserver.com.conf``::

    $HTTP["host"] == "cloud.myserver.com" {
            ...
            proxy.server = (
                    "/http-bind" => (
                            ( "host" => "127.0.0.1", "port" => 5280 )
                    )
            )
    }

Nginx
^^^^^
Enable the proxy pass in your Nginx vhost config::

    server {
            ...
            location /http-bind {
                    proxy_pass http://127.0.0.1:5280;
                    proxy_set_header Host $host;
                    tcp_nodelay on;

            }
    }

XMPP server
-----------

Prosody
^^^^^^^
If you encounter problems with BOSH, please add these lines to ``prosody.cfg.lua``::

    consider_bosh_secure = true
    cross_domain_bosh = true

Ejabberd
^^^^^^^^

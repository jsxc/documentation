File Transfer
=============

Methods
-------
In general JSXC supports currently data channels (WebRTC) and http upload for file transfer.
If http upload is enabled it is the preferred method. If the file is larger as the maximum
upload limit, JSXC will fall back to data channels if available.

HTTP Upload
^^^^^^^^^^^
To use http upload your server should support CORS. If it doesn't you have to proxy
those request and add the CORS header by yourself as in the example shown.

ejabberd Configuration
""""""""""""""""""""""
Ejabberd `mod_httpupload <https://docs.ejabberd.im/admin/configuration/#modhttpupload>`_::

    listen:
    ...
    -
        port: 5443
        module: ejabberd_http
        tls: true
        certfile: "/etc/ejabberd/certificate.pem"
        request_handlers:
        ...
        "upload": mod_http_upload
        ...
    ...

    modules:
    ...
    mod_http_upload:
        docroot: "/ejabberd/upload"
        put_url: "https://@HOST@:5443/upload"
        custom_headers:
        "Access-Control-Allow-Origin": "*"
        "Access-Control-Allow-Methods": "OPTIONS, HEAD, GET, PUT"
        "Access-Control-Allow-Headers": "Content-Type"
    ...

.. warning::
    Ejabberd ignores custom headers if your put url is different from your
    xmpp domain. See `processone/ejabberd#1482 <https://github.com/processone/ejabberd/issues/1482)>`_.

Prosody configuration
"""""""""""""""""""""
Prosody `mod_http_upload <https://modules.prosody.im/mod_http_upload.html>`_::

    Component "localhost" "http_upload"
    http_external_url = "https://EXTERNAL_URL/"

    http_upload_file_size_limit = 10485760


Apache configuration::

    <VirtualHost *:443>
            ServerName EXTERNAL_URL

            ...

            <Location /upload/>
            # Allow cross site requests
            Header always set Access-Control-Allow-Origin "*"
            Header always set Access-Control-Allow-Headers "Content-Type"
            Header always set Access-Control-Allow-Methods "OPTIONS, PUT, GET"

            RewriteEngine On

            # modify status code of preflight request
            RewriteCond %{REQUEST_METHOD} OPTIONS
            RewriteRule ^(.*)$ $1 [R=200,L]
            </Location>

            SSLProxyEngine on

            # Just for testing
            #SSLProxyVerify none
            #SSLProxyCheckPeerCN off
            #SSLProxyCheckPeerName off
            #SSLProxyCheckPeerExpire off

            ProxyPass /upload/ https://localhost:5281/upload/
    </VirtualHost>

WebRTC data channel
^^^^^^^^^^^^^^^^^^^
See our special :doc:`WebRTC page <webrtc>`.

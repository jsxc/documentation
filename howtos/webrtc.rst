WebRTC how to
=============

Why STUN/TURN?
--------------

A STUN (Session Traversal Utilities for NAT) server will allow our two
end-nodes to know what their public IP is, as we most often sit behind
a router in a LAN with private IP addresses. It is only used for that
"getting to know each other" phase used to gather all informations
about how (if proven possible) establishing our peer-to-peer WebRTC
communication.

A TURN (Traversal Using Relay NAT) server is a relay server used when
peer-to-peer connection cannot be established. In that case your only
option is to use an external server as a relay. Symmetrical NAT,
encountered more often in corporate networks, is typically the kind
of NAT for which a TURN server will be used as a workaround to
establish communication.

Public STUN/TURN Servers
------------------------

stun.stunprotocol.org
    (STUN only) is used by default in JSXC. Is known to be `prone to DDoS attacks <https://groups.google.com/forum/#!topic/stunprotocol/7b7i6jlAVTs>`_.

    .. warning::

        For Russia and parts of Ukraine, this server resolves to 127.0.0.1
        (probably as a result of anti-DDoS actions taken by server maintainers).
        If you experience problems with WebRTC connectivity in JSXC,
        first of all check the STUN server availability.

    URL: ``stun:stun.stunprotocol.org``
Google STUN server
    (STUN only)

    URL: ``stun:stun.l.google.com:19302``
numb.viagenie.ca
    (STUN/TURN) is a public STUN/TURN server. Requires registration.

    .. warning::

        This server is known not to work with Firefox (fails to collect srflx and relay entries).

    URL: `turn:numb.viagenie.ca`

Private STUN/TURN Server
------------------------

Install and configure coturn
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Below commands are for Debian, adjust to you distribution's package manager. We
need openssl version 1.0.2 minimum to support DTLS (Datagram TLS). I used the
testing repo to install recent versions of both **openssl** and **coturn**::

    apt install openssl/stretch coturn/stretch

You should get validated checks regarding security protocols supported when restarting coturn::

    0: TLS supported
    0: DTLS supported
    0: DTLS 1.2 supported
    0: TURN/STUN ALPN supported
    0: Third-party authorization (oAuth) supported
    0: GCM (AEAD) supported
    0: OpenSSL compile-time version: OpenSSL 1.0.2j  26 Sep 2016 (0x100020af)

Now for the configuration (in ``/etc/turnserver.conf``), a minimum working conf dims down to::

    listening-port=3478
    tls-listening-port=5349
    alt-listening-port=3479
    alt-tls-listening-port=5350
    listening-ip=PUB.IP.NUM.1
    listening-ip=PUB.IP.NUM.2
    relay-ip=PUB.IP.NUM.1
    min-port=49152
    max-port=65535
    verbose
    fingerprint
    use-auth-secret
    static-auth-secret
    userdb=/var/lib/turn/turndb
    realm=example.com
    cert=/etc/ssl/certs/coturn_ca.crt
    pkey=/etc/ssl/private/coturn.key
    dh-file=/etc/turn/dhparam.pem
    no-stdout-log
    log-file=/var/log/turn/turn.log

    no-sslv3
    no-tlsv1

This is set up to enable STUN features as well as TURN features. The TLS key/certs
have to be fully functional, as TLS is a requirement and not an option (works
perfectly fine with Letsencrypt certificate). You need 2 public IPs for STUN to do its magic.

coturn authentication
^^^^^^^^^^^^^^^^^^^^^
For TURN, because it handles the whole stream, we want it to only accept relaying
authenticated nodes. To do that, you need to create at least a **user account**
and a **shared secret**. They both will be used for ephemeral credential validation.
In your terminal, generate an account and declare your shared secret via
**turnadmin** command::

    turnadmin -a --db /var/lib/turn/turndb -u username -r example.com -p XXXXXX
    turnadmin --db /var/lib/turn/turndb -r example.com --set-secret=XXXXXXXXXXXX

.. note::

    from what I gathered, the user password is not used for ephemeral
    credentials, only for long-term credentials, which are **not secure**.

Configure STUN/TURN server in JSXC
----------------------------------

Static
^^^^^^
You can pass your STUN/TURN configuration directly to JSXC as init option
with the key `RTCPeerConfig.iceServers` using the format described in the
`W3C WebRTC working draft <https://www.w3.org/TR/webrtc/#rtciceserver-dictionary>`_::

    RTCPeerConfig: {
        /** ICE servers like defined in http://www.w3.org/TR/webrtc/#idl-def-RTCIceServer */
        iceServers: [{
            urls: ['stun:stun.domain1.org', 'stun:stun.domain2.org']
        }, {
            urls: 'turn:turn.domain3.org',
            username: 'user',
            credential: 'pass'
        }]
    }

Dynamic
^^^^^^^
If you like to generate STUN/TURN parameters on the fly, just pass
``RTCPeerConfig.url`` as init option to JSXC. The endpoint has to respond
with a JSON encoded representation of `RTCPeerConfig <https://github.com/jsxc/jsxc/blob/master/src/jsxc.lib.options.js#L244>`_::

    RTCPeerConfig: {
        url: '/getWebRTCConfig.php',

        /** If true, jsxc send cookies when requesting RTCPeerConfig from the url above */
        withCredentials: false,
    }

Resources
---------
`WebRTC Troubleshooter <https://test.webrtc.org>`_
    tests all your WebRTC parameter, like Camera, Network or Connectivity.
`Trickle ICE <https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/>`_
    can be used to check general STUN/TURN server availability and functioning.
`NAT-Analyzer <http://nattest.net.in.tum.de/>`_
    is a tool to check your NAT type (full cone, symmetric etc.) Requires Java.

JSXC for SOGo
=============

.. warning::

    The SOGo version of JSXC is currently unmaintained.

Get the code
------------
Packed version
^^^^^^^^^^^^^^
Download the latest version from `releases <https://github.com/jsxc/jsxc.sogo/releases>`_
and extract it to ``/usr/lib/GNUstep/SOGo/WebServerResources/``.

Development version
^^^^^^^^^^^^^^^^^^^
::

    cd /opt
    git clone https://github.com/jsxc/jsxc.sogo sjsxc
    cd sjsxc
    git submodule update --init --recursive
    ln -s /opt/sjsxc /usr/lib/GNUstep/SOGo/WebServerResources/

JSXC Configuration
------------------
It is good to first make sure you can connect and established XMPP communications
before configuring the WebRTC part (which should anyway work most of the time
right off with default configuration).

Rename ``sjsxc/js/sjsxc.config.sample.js`` to ``sjsxc/js/sjsxc.config.js``
and adjust the values for xmpp server, bosh url and xmpp domain.

Example
^^^^^^^
Here below is an example of a working config file with few options although
sufficient to get JSXC plugin to connect to your XMPP server.

File ``sjsxc.config.js``::

    /**
    * feel free to browse through ./jsxc/src/jsxc.options.js to see possible configurations options
    **/

    var sjsxc = {};
    sjsxc.config = {
        /** enable chat by default? */
        enable: true,

        /** JSXC options. */
        jsxc: {
            xmpp: {
                /** url to bosh server binding. Adapt port to the one you declared in your XMPP server's config */
                url: 'https://xmpp.example.com:7443/http-bind/',

            /** domain part of your jid */
                domain: 'example.com',

                /** which resource should be used? Blank, means random. */
                resource: '',

                /** Allow user to overwrite xmpp settings? */
                overwrite: true,

                /** Should chat start on login? */
                onlogin: true
            }
        }
    };

.. note::

    it might be a good idea to use a reverse proxy for reaching the BOSH server
    (`url` parameter then becoming `https://xmpp.example.com/http-bind/`,
    otherwise tight-up networks would prevent the user to connect to XMPP's port.

SOGo configuration
------------------
Add ``SOGoUIAdditionalJSFiles`` to your sogo config (``/etc/sogo/sogo.conf``).

Packed version
^^^^^^^^^^^^^^
::

    {
        [...]

        SOGoUIAdditionalJSFiles = (
            "sjsxc/js/lib/jquery.min.js", // only SOGo v3
            "sjsxc/js/lib/jquery.ui.min.js",
            "sjsxc/js/jsxc/lib/jquery.slimscroll.js",
            "sjsxc/js/jsxc/lib/jquery.fullscreen.js",
            "sjsxc/js/jsxc/lib/jsxc.dep.min.js",
            "sjsxc/js/jsxc/jsxc.min.js",
            "sjsxc/js/sjsxc.config.js",
            "sjsxc/js/sjsxc.js"
        );

        [...]
    }

Development version
^^^^^^^^^^^^^^^^^^^
::

    {
        [...]

        SOGoUIAdditionalJSFiles = (
            "sjsxc/js/lib/jquery.min.js", // only SOGo v3
            "sjsxc/js/lib/jquery.ui.min.js",
            "sjsxc/js/jsxc/dev/lib/jquery.slimscroll.js",
            "sjsxc/js/jsxc/dev/lib/jquery.fullscreen.js",
            "sjsxc/js/jsxc/dev/lib/jsxc.dep.js",
            "sjsxc/js/jsxc/dev/jsxc.js",
            "sjsxc/js/sjsxc.config.js",
            "sjsxc/js/sjsxc.js"
        );

        [...]
    }

Restart sogo service
--------------------
::

    sudo service sogo restart

Debug
-----
First off, make sure your BOSH server is accessible, and that the certificate is valid for HTTPS.
One way to do that is prepare a generic test file (_testBosh.txt_) that you'll call via **curl** command :

Content of the file ``testBosh.txt``::

    <body content='text/xml; charset=utf-8'
        from='user@localhost'
        hold='1'
        rid='1573741820'
        to='localhost'
        wait='60'
        xml:lang='en'
        xmpp:version='1.0'
        xmlns='http://jabber.org/protocol/httpbind' xmlns:xmpp='urn:xmpp:xbosh'/>

Save the file locally on your computer and run::

    curl -X POST -d@testBosh.txt  https://xmpp.example.com:7443/http-bind/

If you get this kind of output, you are good to go as far as BOSH access to XMPP server is concerned, with valid certificate for HTTPS access.
::

    <body xmlns="http://jabber.org/protocol/httpbind" xmlns:stream="http://etherx.jabber.org/streams"
        from="example.com" authid="55j3i8xlx2" sid="55j3i8xlx2" secure="true"
        requests="2" inactivity="30" polling="5" wait="60">
        <stream:features>
            <mechanisms xmlns="urn:ietf:params:xml:ns:xmpp-sasl">
                <mechanism>PLAIN</mechanism>
            </mechanisms>
            <bind xmlns="urn:ietf:params:xml:ns:xmpp-bind"/>
            <session xmlns="urn:ietf:params:xml:ns:xmpp-session">
                <optional/>
            </session>
        </stream:features>
    </body>

Finally, JSXC core being all about **Javascript**, you need to open your browser
console (Ctrl-Shift-i on Firefox) and filter all JS information.

Next
----
Once JSXC is well anchored in your SOGo interface and you have a fully functionnal OTR-capable integrated chat,
it is now time to test and use **video chat**.
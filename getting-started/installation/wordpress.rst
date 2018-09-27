JSXC for WordPress
==================
In addition to the WordPress installation you need a running XMPP server
with BOSH support. Next you have to configure your XMPP server, maybe
activate your BOSH module and to make sure, that your BOSH Server is
reachable by your website. If your XMPP server supports `CORS <https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS>`_
everything should be fine.

#. Install web server, xmpp server, (bosh server)
#. Download and extract [jsxc](https://github.com/jsxc/jsxc/releases) to a folder of your choice inside of your WordPress theme folder (e.g. /data/mydomain.com/webroot/wp-content/themes/mytheme/jsxc).
#. Create a ``jsxc_client.js`` file in your scripts directory (e.g. /data/mydomain.com/webroot/wp-content/themes/mytheme/js)
   and insert the following code into it::

        $(function($) {
        jsxc.init({
            loginForm: {
                form: '#page-login-form',
                jid: '#page-user-login',
                pass: '#page-user-pass'
            },
            logoutElement: $('#logout-element'),
            root: '../jsxc/',
            displayRosterMinimized: function() {
                return true;
            },
            xmpp: {
                url: 'http://YOUR_XMPP_SERVER.com:7070/http-bind/',
            domain: 'YOUR_DOMAIN',
                resource: 'jsxc'
            }
        });
        });

   Replace ``YOUR_DOMAIN`` with the domain of you XMPP server and ``http://YOUR_XMPP_SERVER.com:7070/http-bind/``
   with a correct URL of your BOSH server. Also replace ``#page-login-form``, ``#page-user-login``, ``#page-user-pass``
   and ``#logout-element`` with correct id's of your site.

#. Create a ``jsxc-custom.css`` file inside of the styles directory of your site (e.g. ``/data/mydomain.com/webroot/wp-content/themes/mytheme/css/``).
#. Insert the following lines of code into some shared page (e.g. ``header.php``)::

    <link href="<?php echo get_template_directory_uri(); ?>/jsxc/css/jquery-ui.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<?php echo get_template_directory_uri(); ?>/jsxc/css/jsxc.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<?php echo get_template_directory_uri(); ?>/jsxc/css/jsxc.webrtc.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<?php echo get_template_directory_uri(); ?>/css/jsxc-custom.css" media="all" rel="stylesheet" type="text/css" />
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jquery.min.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jquery.ui.min.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jquery.colorbox-min.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jquery.slimscroll.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jquery.fullscreen.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/lib/jsxc.dep.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/jsxc/jsxc.min.js"></script>
    <script src="<?php echo get_template_directory_uri(); ?>/js/jsxc_client.js"></script>

**Verify that jquery is not loaded twice, otherwise the client will not work correctly.**
6. Open the main page of your site and notice the jsxc is working.
7. Investigate the CSS styles of jsxc and overwrite the required styles in ``jsxc-custom.css`` to match your site's UI.
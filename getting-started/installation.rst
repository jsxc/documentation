Installation
============

.. toctree::
   :maxdepth: 1
   :caption: Prebuild packages:

   installation/nextcloud
   installation/wordpress
   installation/ilias
   installation/sogo

Overview
--------
#. Install web server, xmpp server, (bosh server)
#. Download and extract `jsxc <https://github.com/jsxc/jsxc/releases>` to a folder of your choice (e.g. ``jsxc.example``)
#. Create two folders in your directory ``css`` and ``js``
#. Create a file in each folder: ``jsxc.example.css`` in ``css`` and ``jsxc.example.js`` in ``js``
#. Adjust permissions

Your folder structure should now look like::

    - jsxc.example/
        - jsxc/
            - css/
                - jsxc.example.css
            - js/
                - jsxc.example.js

Include
-------
Now include all these files in your template::

    <!-- Javascript -->
    <script src="/jquery.min.js"></script>
    <script src="jsxc.example/jsxc/jsxc.bundle.js"></script>
    <script src="jsxc.example/js/jsxc.example.js"></script>

    <!-- Stylesheets -->
    <link href="jsxc.example/jsxc/styles/jsxc.bundle.css" media="all" rel="stylesheet" type="text/css" />
    <link href="jsxc.example/css/jsxc.example.css" media="all" rel="stylesheet" type="text/css" />

Configure
---------
Add the following lines to our ``jsxc.example.js``::

    $(function() {
        jsxc.init();

        let formElement = $('#form');
        let usernameElement = $('#username');
        let passwordElement = $('#password');

        function getSettings(username, password) {
        return Promise.resolve({
            xmpp: {
            url: '/http-bind/',
            domain: 'localhost',
            }
        });
        }

        jsxc.watchForm(formElement, usernameElement, passwordElement, getSettings);
    });

Adjust the values according to your application.

Attach handler
--------------
TODO

Customize style
---------------
TODO

Enjoy
-----
Now you should be ready to go.
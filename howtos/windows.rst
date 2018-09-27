Using JSXC on Windows with IIS
==============================
I'm not going to go in full details yet on how to fully setup each point.

I actually have a domain, and SSL certificates that I created using
Let's Encrypt, and I'm using https for my entire setup. So this might
make things tricky for you if you are only using http with no actual
domain at all, but http://localhost/ should just be fine I think??? lol.

I will assume for the most part you do have some knowledge and experience
with IIS, php, MySQL, permissions, configuration files, and etc... You
can search online using Google or other for "How to secure IIS", "How to secure wtv".

My setup:

- OS: Windows Server 2016 Data Center (Can be used with any OS that supports IIS)
- WWW Server: IIS 10 (Assumed installed)

    - IIS `Web Platform Installer <https://www.microsoft.com/web/downloads/platform.aspx>`_ v5 so you can install next two easy
    - IIS `Application Request Routing <https://www.iis.net/downloads/microsoft/application-request-routing>`_ for reverse proxy
    - IIS `URL ReWrite <https://www.iis.net/downloads/microsoft/url-rewrite>`_ for reverse proxy

- DNS Server: `BIND9 <https://www.isc.org/downloads/bind/) to create internal domains (Assumed installed / Optional>`_
- php: `v7.2.2 <http://windows.php.net/download) for Windows (Assumed installed>`_
- XMPP Server: `ejabberd <https://www.ejabberd.im>`_ v18.01
- DB: `MySQL <https://www.mysql.com/downloads/) Community Edition (Assumed installed / Optional>`_

Step 1
------
Make sure your OS, IIS, php, MySQL, Web Application Platform, Application Request Routing,
and URL ReWrite module are installed, configured, and working. If you plan on actually
testing this outside of localhost, don't forget to open your firewall ports on the server,
port forwarding in your router, and to actually get a domain instead of making fake internal
domains local to the server using BIND9 DNS server, any other DNS server, or even just using the host file.

Install ejabberd XMPP Server on the same machine, just follow the steps in the installer,
once it ask you for host name you can put domain.com or wtv domain you plan on using for
testing. Run the "Start ejabberd shortcut" created by the installer on the desktop. Your
web browser will open and say the ejabberd has started if all went well. Login to the admin
page http://localhost:5280/admin/ with the user/pwd you typed in the ejabberd installer.
You can use this admin page to create more users but for now we can do testing with your
admin@domain.com account created during installation of ejabberd.

.. important::

    Once ejabberd is installed and running, open up your web browser and test "http://localhost:5280/http-bind/"
    or "http://localhost:5280/bosh/" (they both do the same thing) to confirm they are accessible and working.
    This is what we are going to create a URL ReWrite rule or aka alias for using reverse proxy".

Step 2
------
Make a folder called www on any drive outside Inetpub. This will make your life more easy
for editing instead of having to be in admin mode all the time, security, and backing up.

.. image:: https://s25.postimg.org/94ccfdien/www-location.png

Change security permissions to allow the user IIS_IURS Read and Execute permissions,
depending on what you are doing some subfolders or files might need write access to.

.. image:: https://s25.postimg.org/byfhstsan/www-permissions.png

Step 3
------
Decide now if you want JSXC to be a domain or subdomain. Just to be clean, I name my folders
like domain.com for a folder/domain or sub.domain.com for a folder/subdomain aka "C:\www\domain.com\"
or "C:\www\sub.domain.com". I'll be using domain.com for the example.

Create a folder called domain.com in your www folder and dump the JSXC files in this folder.
Configure your JSXC install. I'm only using the internal database for the ejabberd server.

.. important::

    Very important create another folder called bosh or http-bind in your domain.com
    folder, this will be used to create the reverse proxy to allow JSXC XMPP Client
    to talk with the ejabberd XMPP Server. It will also store a Web.config file that
    actually has the settings to do the reverse proxy. So your link would be http://domain.com/bosh/
    or http://domain.com/http-bind/" wtv you decided ejabbered works with both links
    using /bosh/ or /http-bind/ same as JSXC does.** -- I would like to thank
    @skyfox675 for the help on this one and showing his config file sample,
    because I had never done proxies using IIS before.

By now you should of setup something like roundcube webmail, nextcloud, or owncloud to
allow you to use JSXC as a plugin/addon, if not you will have to make your own little html or
php app to allow you to even use JSXC. Just follow the `JSXC installation <https://www.jsxc.org/installation.html>`_
section, and pay attention to the "`Do you want to integrate JSXC into your own web application <https://github.com/jsxc/jsxc/wiki/Install-jsxc>`_".

Step 4
------

.. important::

    Enabling IIS as a proxy server using ARR.

You have to click on the server itself in the IIS Manager on the left, if you have installed
Application Routing and Request you should see Application Routing and Request Cache as an
icon on the right, double click the icon.

.. image:: https://s25.postimg.org/5kv02y2e7/iis-proxy-location.png

Now that you have Application Routing and Request Cache open, look to the right you
should see "Server Proxy Settings" so single click it.

.. image:: https://s25.postimg.org/sz2zevs1b/iis-proxy-location-settings.png

Don't worry about all the settings on this page, they can be left to default, all you
need to do is enable it and click apply on the right.

.. image:: https://s25.postimg.org/byk36a7b3/enable-proxy.png

Step 5
------
.. important::

    Setting up the Web.config file with rules for URL ReWrite.

You can do this two ways either using IIS Manager, expand your website/domain.com and click
on the subfolder bosh or http-bind wtv you decided to name it, and using the GUI to create the reverse proxy url rewrite.

.. image:: https://s25.postimg.org/45tfebw73/urwl-rewrite-location.png

Or just creating a text file using notepad and saving it in your bosh or http-bind folder
calling Web and saving it as a config file not a txt file making it be "Web.config".

I used the GUI to make the server variables needed for this ReWrite to work, and used
notepad to actually write the config file provided by @skyfox675 in the provided
`sample <https://github.com/jsxc/jsxc/issues/353#issuecomment-366457031>`_.

You need to create some server variables:
1. HTTP_X_FORWARDED_PROTO
2. HTTP_X_FORWARDED_HOST
3. HTTP_X_FORWARDED_PORT
4. ORIGINAL_HOST21

.. image:: https://s25.postimg.org/mldwbt2mn/server-variables-location.png

.. image:: https://s25.postimg.org/ic969n733/server-variables.png

So now travel to Windows File Explorer to "C:\www\domain.com\http-bind" or C:\www\domain.com\bosh"
and create a web.config file if there is none. You can use notepad these files are just text files
in the end. Put this text in your new config file, if there was one already created just add this
into it by modifying what IIS generated. I hope you know what config files are and how to use
them they end up just being xml being just text lol. Don't forget to edit the host variable to be
your domain, in the example I have it set to domain.com on the inboundrule, and for the outboundrule
there is a "/(http-bind)" you could do "/(bosh)" if you wanted, same goes for the localhost:5280 section::

    <!-- THANKS TO @skyfox675 for providing a sample -->
    <!-- I modified the sample to fit my needs and versions -->
    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <system.webServer>
            <rewrite>
                <rules>
                    <rule name="ReverseProxyInboundRuleBOSH" stopProcessing="true">
                        <match url="(.*)" />
                        <action type="Rewrite" url="http://localhost:5280/http-bind/{R:1}" appendQueryString="true" />
                        <serverVariables>
                            <set name="ORIGINAL_HOST21" value="{HTTP_HOST}" />
                            <set name="HTTP_X_FORWARDED_PROTO" value="https" />
                            <set name="HTTP_X_FORWARDED_PORT" value="5443" />
                            <set name="HTTP_X_FORWARDED_HOST" value="domain.com" />
                        </serverVariables>
                    </rule>
                </rules>
                <outboundRules>
                    <rule name="ReverseProxyOutboundRuleBOSH" preCondition="ResponseIsHtml1">
                        <match filterByTags="A, Form, Img" serverVariable="RESPONSE_LOCATION" pattern="^http://[^/]+/(.*)" />
                        <action type="Rewrite" value="http://{ORIGINAL_HOST21}/{C:1}/{R:1}" />
                        <conditions>
                            <add input="{ORIGINAL_HOST21}" pattern=".+" />
                            <add input="{URL}" pattern="^/(http-bind)" />
                        </conditions>
                    </rule>
                    <preConditions>
                        <remove name="ResponseIsHtml1" />
                        <preCondition name="ResponseIsHtml1">
                            <add input="{RESPONSE_CONTENT_TYPE}" pattern="^text/html" />
                            <add input="{RESPONSE_STATUS}" pattern="3\d\d" />
                        </preCondition>
                    </preConditions>
                </outboundRules>
            </rewrite>
            <httpErrors errorMode="DetailedLocalOnly" />
            <directoryBrowse enabled="false" />
        </system.webServer>
    </configuration>

What all this does is convert http://domain.com/http-bind/ from the web server side to http://localhost:5280/http-bind"
on the ejabberd xmpp server side on the same machine, could be a different machine if you wanted. This also terminates
https if you are using it at the IIS server, but that's another issues for another time.

So for every single application you use JSXC client in with ejjaberd server, you would tell it your xmpp server
is located at http://domain.com/http-bind/ so the local machine and remote machines can find the xmpp server,
if you would not do this and only did localhost, the remote machines would never find the xmpp server because locally
to themselves there is no server.

Doing this also allows you to not have to create more bindings in IIS for your website aka virtual-host causing
other issues. My only bindings on IIS for the site I have JSXC running on is port 80 and 443, and I redirect all to 443.

And you are done and things should be working.

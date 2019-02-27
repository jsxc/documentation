API
===

.. note::

    We use a Typescript-like syntax to describe our API. For example a following question mark means that this argument or property is optional.

General
-------

<constructor> JSXC(options?)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You have to initialize JSXC with some options so it can learn about your environment. If you have already some established sessions, those will be restored.

Arguments
"""""""""
* ``options.appName?`` (string)
    Name of container application (e.g. Nextcloud or SOGo).

    Default: ``"web applications"``
* ``options.lang?`` (string)
    Default language.

    Default: ``"en"``
* ``options.autoLang?`` (boolean)
    Auto language detection.

    Default: ``true``
* ``options.rosterAppend?`` (string)
    Query string for element which should contain your contact list.

    Default: ``"body"``
* ``options.rosterVisibility?`` ("shown"|"hidden")
    Default roster visibility.

    Default: ``"shown"``
* ``options.hideOfflineContacts?`` (boolean)
    Set to true if you want to hide offline contacts.

    Default: ``false``
* ``options.loadOptions?`` (jid: string, password: string) => Promise<{[id: string]: {[key: string]: any}}>
    If you store option changes with ``options.onOptionChange`` you probably
    want to restore them on the next login. Just return an object with all id's
    and the corresponding values.

    Default: ``undefined``
* ``options.loadConnectionOptions?`` (username: string, password: string) => Promise<ISettings>
    This option can provide connection options for every form login (form
    watcher, login dialog).

    Default: ``undefined``
* ``options.onOptionChange?`` (id: string, key: string, value: any, exportId: () => any) => void
    This function is called every time the user changes a option.

    Default: ``undefined``
* ``options.getUsers?`` (search: string) => Promise<{[uid: string]: string}>
    If you like to provide auto suggestions if the user is adding a contact, you
    should add this function. Key has be a JID or UID and value a display name.

    Default: ``undefined``
* ``options.RTCPeerConfig.ttl?`` (number)
    Time-to-live for config from url.

    Default: ``3600``
* ``options.RTCPeerConfig.iceServers?`` (array)
    ICE servers like defined in http://www.w3.org/TR/webrtc/#idl-def-RTCIceServer;

    Default: ``[{ urls: 'stun:stun.stunprotocol.org' }]``
* ``options.onlineHelp?`` (string)
    Default: ``http://www.jsxc.org/manual.html``
* ``options.storage?`` (localStorage|sessionStorage)
    Storage backend. Has to implement the Storage interface of the Web Storage API.

    Default: ``localStorage``
* ``options.disabledPlugins?`` (array<string>)
    Default: ``[]``
* ``options.connectionCallback?`` ((jid: string, status: number, condition?: string) => void)
    Default: ``undefined``
* ``options.onUserRequestsToGoOnline?`` (() => void)
    If the user requests to go online again, this function is called. Default: The login dialog is shown.

    Default: ``loginDialog``

jsxc.numberOfCachedAccounts: number
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Number of restored connections.

jsxc.start(boshUrl, jid, sid, rid)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
With JSXC you can also continue a previous established BOSH session.

Arguments
"""""""""
* ``boshUrl`` (string)
    The URL of your BOSH service.
* ``jid`` (string)
    Your Jabber Id with or without resource. E.g. ``klaus@jsxc.org`` or ``klaus@jsxc.org/desktop``.
* ``sid`` (string)
    Your Session ID from your pre-bind session.
* ``rid`` (string)
    Your Request ID from your pre-bind session.

Returns
"""""""
``Promise<void>``
    Promise is resolved if the connection is established and the UI loaded.

jsxc.start(boshUrl, jid, password)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Start a new connection with the given service and credentials.

Arguments
"""""""""
* ``boshUrl`` (string)
    The URL of your BOSH service.
* ``jid`` (string)
    Your Jabber Id with or without resource. E.g. ``klaus@jsxc.org`` or ``klaus@jsxc.org/desktop``.
* ``password`` (string)
    Corresponding password to your Jabber Id.

Returns
"""""""
``Promise<void>``
    Promise is resolved if the connection is established and the UI loaded.

jsxc.start()
^^^^^^^^^^^^
Show an empty contact list which allows the user to connect to a service by itself.

Returns
"""""""
``Promise<void>``
    Promise is resolved if the UI is loaded.

jsxc.startAndPause(boshUrl, jid, password)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Same as ``jsxc.start``, but just connects to the XMPP and stops afterwards. Can be used to connect before a form is submitted, or similar.

Returns
"""""""
``Promise<void>``
    Promise is resolved if the connection is established.

jsxc.watchForm(formElement, usernameElement, passwordElement)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Watch a login form and use credentials to establish an XMPP connection. You can
provide options with ``options.loadConnectionOptions``.

Arguments
"""""""""
* ``formElement`` (JQuery)
    Form element which should be watched for a submit event.
* ``usernameElement`` (JQuery)
    If the form is submitted get the username from this element.
* ``passwordElement`` (JQuery)
    If the form is submitted get the password from this element.

User interface
--------------

jsxc.addMenuEntry(options)
^^^^^^^^^^^^^^^^^^^^^^^^^^
Add a new entry to the main menu.

Arguments
"""""""""
* ``options.id`` (string)
    ID of your menu entry.
* ``options.handler`` ((ev) => void)
    This handler is called if the user clicks on the menu entry.
* ``options.label`` (string)
    Every menu entry needs a text label.
* ``options.icon?`` (string)
    If you provide a URL or Base64 encoded image, an icon is shown beside the label.
* ``options.offlineAvailable?`` (boolean)
    If your entry should also be clickable while the user is offline, set this to ``true``.
    Default: ``false``

jsxc.toggleRoster()
^^^^^^^^^^^^^^^^^^^
Show or hide the contact list.

Development
-----------

jsxc.enableDebugMode()
^^^^^^^^^^^^^^^^^^^^^^
Enable debug mode for more log messages.

jsxc.disableDebugMode()
^^^^^^^^^^^^^^^^^^^^^^^
Disable debug mode.

jsxc.deleteAllData()
^^^^^^^^^^^^^^^^^^^^
Delete all data stored by JSXC in your data backend.

.. warning::

    This function is only available in debug mode.

Returns
"""""""
``number``
    Number of deleted items.

Services
--------

JSXC.register(service, domain, callback?)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Arguments
"""""""""
* ``service`` (string)
    The URL of your BOSH service.
* ``domain`` (string)
    Register a new user with this domain.
* ``callback?`` ((form: Form) => Promise<Form>)
    If you like to display a custom form, provide a callback.

Returns
"""""""
``Promise<void>``
    Promise is resolved if the user was successfully registered.

JSXC.testBOSHServer(url, domain)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Allows you test if a BOSH server is reachable and serving the given domain.

Arguments
"""""""""
* ``url`` (string)
    URL which you like to test.
* ``domain`` (string)
    Domain which you like to test.

Returns
"""""""
``Promise<string>``
    If the BOSH server is reachable the promise resolves with a constant success string.

    In the error case the promise is resolved with an error object. You can call ``toString()`` to get the
    error message in english or ``getErrorCode()`` to get a more generic error code. You find a list of all
    messages and codes in ``src/api/v1/testBOSHServer.ts``.

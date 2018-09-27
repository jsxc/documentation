Version 2 (draft)
=================

.. warning::

  This version is still in development!

Schema
------
All API access should over HTTPS, and accessed the ``https://YOUR_CLOUD/index.php/apps/ojsxc/api/v2/``. All
data is sent and received as JSON. Every request has to contain a signature to verify the request.

Client Errors
-------------

500 Internal Server Error:
  ``{"result": "error", "data": {"msg":"An error occured"}}``

Header Signature
----------------
Every request to an API endpoint needs a valid X-JSXC-SIGNATURE header of the form ``HASH_ALGO=hmac(HASH_ALGO, REQUEST_BODY, API_SECRET)``.

Endpoints
---------

Check Password
^^^^^^^^^^^^^^
::

  POST /checkPassword

Parameters
""""""""""

========= =============== =============
Name      Type            Description
========= =============== =============
username  string
password  string
domain    string          The domain is used to check additionally
                          the password for ``username@domain`` (optional)
========= =============== =============

Response
""""""""
::

  Status: 200 OK

  {
    "result": "noauth"
  }

::

  Status: 200 OK

  {
    "result": "success",
    "data": {
      "uid": "foobar"
    }
  }

User exists
^^^^^^^^^^^
::

  POST /isUser

Parameters
""""""""""

========= =============== =============
Name      Type            Description
========= =============== =============
username  string
domain    string          The domain is used to test additionally
                          the user ``username@domain`` (optional)
========= =============== =============

Response
""""""""
::

  Status: 200 OK

  {
    "result": "success",
    "data": {
      "isUser": true
    }
  }

Get shared roster
^^^^^^^^^^^^^^^^^
::

  POST /sharedRoster

Parameters
""""""""""

========= =============== =============
Name      Type            Description
========= =============== =============
username  string
domain    string          The domain is used to get the shared
                          roster for ``username@domain`` (optional)
========= =============== =============

Response
""""""""
::

  Status: 200 OK

  {
    "result": "success",
    "data": {
      "sharedRoster": {
        "fritz": {
          "name": "Fritz Froh",
          "groups": ["group1", "group2"]
        },
        "georg": {
          "name": "Georg Geizig",
          "groups": ["group3"]
        }
      }
    }
  }

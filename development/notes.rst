Developer notes
===============

Get code
--------
Please execute the following commands to get a copy of the code:

Core
^^^^
::

    git clone https://github.com/jsxc/jsxc.git

Apps
^^^^
::

    git clone https://github.com/nextcloud/jsxc.nextcloud.git
    # and/or
    git clone https://github.com/jsxc/jsxc.sogo.git
    # and/or
    git clone https://github.com/jsxc/jsxc.ilias.git

Install yarn
------------
We use `yarn <https://yarnpkg.com>`_ as our package manager. Please follow there
`docs <https://yarnpkg.com/en/docs/install#debian-stable>`_ to install it.

.. warning::

    We used `npm <https://www.npmjs.com/>`_ and `grunt <http://gruntjs.com/>`_ in the passed to
    concatenate, convert, and validate our source files. It's likely that you still find it
    at some places.

First install all dependencies with `yarn install`. To build the project, just run ``yarn start`` 
in its top-level directory. If you like to start a development server and watch all files for 
changes, some project offer you `yarn dev`.

Now you are ready for development.


Workflow
--------
- run ``yarn watch`` in the project root folder
- make your modifications in `src/` and `scss/`
- check your results on `example/index.html`
- `git add ...`
- `git commit` (should run our pre-commit hook)
- `git push`


Notes
-----
Yarn commands
^^^^^^^^^^^^^
A few helpful yarn commands you should know to simplify your life.

- `start` create a production ready build
- `watch` create a development build and rerun on file changes
- `dev` similar to `watch`, but it will start a development server
- `fix` beautifies all files and makes sure the pre-commit hook is satisfied

To run a command, execute `yarn COMMAND`.

Core Structure
^^^^^^^^^^^^^^
TODO

Debugging
^^^^^^^^^
Open your Javascript console (e.g. ctrl+shift+I) and enter `jsxc.storage.setItem('debug', true)` to obtain debug messages.

Locales
-------
We use `webtranslateit.com <https://webtranslateit.com/en/projects/10365-JSXC>`_ to organize our translations
and `wti <https://webtranslateit.com/en/docs/web_translate_it_client/>`_ to synchronise those.

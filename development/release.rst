Creating a release
==================

- update change log
- update translation ``wti pull --all``
- update example
- create build

  - increase version number in ``package.json`` - run ``node scripts/build-release.js`` (use ``--release`` for stable releases)

- update documentation

  - wiki
  - website

- publish to app store, npm and similar
- announce new release

  - blog post
  - twitter
  - mailing list

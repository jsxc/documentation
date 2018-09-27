Creating a release
==================

- update change log
- update translation ``wti pull --all``
- update example
- create build

  - increase version number
  - run ``grunt build:release``
  - create signed commit ``git add build/ && git commit -a -S``
  - sign build package ``gpg --detach-sign archives/BUILD``

- update documentation

  - wiki
  - website

- publish to app store, npm and similar
- announce new release

  - blog post
  - twitter
  - mailing list

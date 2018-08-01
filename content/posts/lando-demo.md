---
title: "Lando demo"
date: 2018-02-21T19:20:20-05:00
categories: ["mozilla", "conduit"]
---
Lando is so close now that I can practically smell the [tibanna][].
Israel put together a quick demo of Phabricator/BMO/Lando/hg running on
his local system, which is only a few patches away from being a
deployed reality.

One caveat: this demo uses Phabricator's web UI to post the patch.  We
highly recommend using [Arcanist][], Phabricator's command-line tool,
to submit patches instead, mainly because it preserves all the
relevant changeset metadata.

With that out of the way, fasten your cape and take a look:

<video src="/videos/phab-lando-transplant-end-to-end.mp4" controls="true">

[tibanna]: https://starwars.wikia.com/wiki/Tibanna
[Arcanist]: https://secure.phabricator.com/book/phabricator/article/arcanist/

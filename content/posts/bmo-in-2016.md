---
title: "BMO in 2016"
date: 2017-01-05T11:54:11-05:00
categories: ["mozilla", "bmo", "bugzilla"]
---
Stuff that landed in 2016
=========================

Here's a sampling of improvements to BMO that were launched in 2016.

Improvements to bug-modal
-------------------------

We've continued to refine the [modal bug view][], aka the "experimental UI".
The BMO team fixed [39 bugs][] relating to the new interface in 2016.
We've got a couple more blockers before we make the modal view
the [default][], which should happen in the middle of January.  We
know there are a still a few outstanding bugs and some missing
functionality, so we will leave the standard view available for a
little while, at least until all the blockers of [bug 1273046][] are
resolved.  All future improvements to the bug view will happen only on
the modal UI, which is not just more usable but also more hackable.

HTML email
----------

There was actually no real work involved here, as HTML email was added
to BMO years ago.  At that time, since it was a new feature, we didn't
enable it by default... and then 4 years went by.  Just a couple weeks
ago a new BMO user suggested that we implement HTML emails, having no
idea that the option was already there (buried in many other
preferences).  That was the prompting we needed to finally enable it
by default.

Readable bug statuses
---------------------

[Emma Humphries][] added readable statuses prominently displayed at
the top of the status panel (in the modal UI only).  They quickly
summarize the status of a bug in a visible place, mainly for triaging
and tracking purposes.

A couple examples:

<img src="/images/readable_status_no_priority.png" width="716px" height="62px">

<img src="/images/readable_status_backlog.png" width="1174px" height="62px">

This is part of Emma's on-going efforts to
[improve contributors' experiences][].

Time zones
----------

One big change we made this year was hopefully completely invisible to
everyone: BMO's database [moved to UTC][].  When BMO was originally
deployed in 1998, the database, being based in California, was set to
Pacific Time.  6 years later someone suggested that UTC would be a
better choice.  When I took over management of the BMO team about 4.5
years ago, I was pretty horrified that a major application would be
running in any time zone other than UTC, not in the least because of
the confusion caused by an hour being repeated every year when PDT
switched back to PST, since the presence or absence of DST is not
noted in the database.  However, we were never able to justify
the required effort to move over to UTC, that is, until last year, as
we were setting up a failover system in AWS.  RDS, the natural choice
for a MySQL-based application, supported only UTC, thus giving us a
hard requirement to migrate.  A heroic effort by dkl got us smoothly
switched over in May 2016.

Memory-usage & perf improvements
--------------------------------

We've known for some time that Bugzilla has a persistent memory leak.
It was never a huge issue because the webheads would automatically
restart Apache processes when their memory usage got too high, but it
is understandably something that lurks in the back of the minds of the
developers working on Bugzilla.  Dylan finally got frustrated enough
to [fix a big leak][], which resulted in the webheads restarting much
less frequently, which in turn led to a performance increase.  He's
been investigating and fixing other such leaks when he finds the time.


Stuff we're wrapping up in 2017
===============================

Some of the bigger projects bled over into 2017.

Content Security Policy
-----------------------

We've been working on implementing CSP in BMO, starting with the
new modal bug view.  It was pretty hairy due to generated HTML, inline
JavaScript, and other old web-dev techniques that make security
harder.  After some back and forth, we're just about there; see
[bug 1286290][] for progress.

Note that CSP can break browser extensions.  Since the modal UI is
relatively new, there are probably not too many extensions designed
for it; however, we'll be spreading CSP over time.  And of course,
we'll be removing the old bug view at some point, which will
definitely break some things.

Elastic Quicksearch
-------------------

In the spring, Dylan hacked up a prototype of a [quicksearch][]
alternative powered by an Elasticsearch index.  It's lightning fast,
so we explored setting it up in production.  Of course a prototype is
always easier than the real thing, and we had to do some structural
work to BMO to make it possible, although that in turn has had side
benefits.  The [indexing code][] is just about ready to roll out, and
while we're verifying that it works correctly, we'll be finishing up
the [search code][].  You can also follow the main [tracker bug][] for
the whole deployment.

New stuff in 2017
=================

We're expecting to wrap up the above features in Q1, and we've already
developed a road map for the first half of 2017 with some fun and
long-awaited features.  Emma will be going over this in another post,
wearing her hat as BMO product manager, a job she has recently, and
graciously, taken on herself!


[modal bug view]: https://globau.wordpress.com/2015/03/31/bmo-new-look/
[fix a big leak]: https://dylanwh.tumblr.com/post/147319029597/bmo-memory-leaks
[39 bugs]: https://bugzilla.mozilla.org/buglist.cgi?chfield=resolution&chfieldfrom=2016-01-01&chfieldvalue=FIXED&resolution=FIXED&chfieldto=2016-12-31&query_format=advanced&component=User%20Interface%3A%20Modal&product=bugzilla.mozilla.org
[default]: https://bugzilla.mozilla.org/show_bug.cgi?id=1150541
[bug 1273046]: https://bugzilla.mozilla.org/show_bug.cgi?id=1273046
[Emma Humphries]: https://emceeaich.dreamwidth.org/tag/planetmozilla
[improve contributors' experiences]: https://emceeaich.dreamwidth.org/195314.html
[moved to UTC]: https://bugzilla.mozilla.org/show_bug.cgi?id=232193
[bug 1286290]: https://bugzilla.mozilla.org/show_bug.cgi?id=1286290
[quicksearch]: https://bugzilla.mozilla.org/page.cgi?id=quicksearch.html
[indexing code]: https://bugzilla.mozilla.org/show_bug.cgi?id=1307478
[search code]: https://bugzilla.mozilla.org/show_bug.cgi?id=1307485
[tracker bug]: https://bugzilla.mozilla.org/show_bug.cgi?id=1184823

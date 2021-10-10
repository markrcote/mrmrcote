---
title: "BMO mid-2014 update"
date: 2014-07-14T13:42:24-04:00
categories: ["mozilla", "bmo"]
---
Here's your mid-year report from the offices, basements, and caverns
of [BMO][]!

![Finn hugging BMO](https://i.imgur.com/qO7c8Pv.gif)

Performance
===========
This year we're spending a lot of time on performance.  As nearly
everyone knows, Bugzilla's an old Perl app from the early days of the
Web, written way before all the technologies, processes, and standards
of today were even dreamt of.  Furthermore, Bugzilla (including BMO)
has a very flexible extension framework, which makes broad
optimizations difficult, since extensions can modify data at many
points during the loading and transforming of data.  Finally, Bugzilla
has evolved a very fine-grained security system, crucial to an open
organization like Mozilla that still has to have a few secrets, at
least temporarily (for security and legal reasons, largely).  This
means lots of security checks when loading or modifying a bug&mdash;and,
tangentially, it makes the business logic behind the UI pretty complex under the hood.

That said, we've made some really good progress, starting with
retrofitting Bugzilla to use memcached, and then instrumenting the
database and templating code to give of reams of data to analyze.
Glob has lots of details in his post on [BMO perf work][]; read it if
you're interested in the challenges of optimizing a legacy web app.
The tl;dr is that BMO is faster than last year; our best progress has
been on the server side of show_bug (the standard Bug view), which,
for authenticated users, is about 15% faster on average than last
year, with far fewer spikes.

Bugs updated since last visit
=============================
Part of an effort to improve developer productivity, in June we rolled
out a feature to give a new way for users to track changes to bugs.
BMO now notes when you visit a bug you're involved in (when you load it in the main
Bugzilla UI or otherwise perform actions on it), and any changes to
that bug which occur since you last visited it will show up in a table
in [My Dashboard][].  [Read more][].

Bugmail filtering
=================
Another improvement to developer productivity centred around
notifications is the new [bugmail filtering][] feature.  Bugzilla
sends out quite a lot of mail, and the controls for deciding when you
want to receive a notification of a change to a bug have been pretty
coarse-grained.  This new feature is extremely customizable, so you
can get only the notifications you really care about.

BzAPI compatibility
===================
There have been several broad posts about this recently, but it's
worth repeating.  The original Bugzilla REST API, known as [BzAPI][], is
deprecated in favor of the new [native REST API][] (on BMO at least; it
isn't yet available in any released version of the Bugzilla product).
If possible, sites currently using BzAPI should be modified to use the
new API (they are largely, but not entirely, compatible), but at a
minimum they should be updated to use the new [BzAPI compatibility layer][],
which is hosted directly on BMO and sits atop the new REST API.
The compatibility layer should act almost exactly the same as BzAPI
(the exceptions being that a few extra fields are returned in a small
number of calls).  At some point in the not-too-distant future, we'll
be (transparently) redirecting all requests to BzAPI to this layer and
shutting down the BzAPI server, so it's better to try to migrate now
while the original BzAPI is still around, in case there are any
lingering bugs in the compatibility layer.

More stuff
==========
* [Comment previews][], so you can verify linkification and other markup.
* [New quicksearch operators][] in addition to the existing ":"
  substring-match operator.
* [Better tracking of reviews][]: just an API for now, but a [UI][] will be
  coming this quarter.
* [Whiteboard tags][] are now documented (add yours if you haven't
  yet!) and linked to from the whiteboard-field help.
* A [proper mentor field][], replacing the previous practice of storing the value in the whiteboard.

As usual, you can see our [current goals and high-priority items][] for
the quarter on the BMO wiki page.

[BMO]: https://wiki.mozilla.org/BMO
[BMO perf work]: http://blog.glob.com.au/2014/07/04/bugzilla-and-performance-2014/
[New quicksearch operators]: http://globau.wordpress.com/2014/01/30/happy-bmo-push-day-80/
[BzAPI]: https://wiki.mozilla.org/Bugzilla:BzAPI
[native REST API]: https://wiki.mozilla.org/Bugzilla:REST_API
[BzAPI compatibility layer]: https://wiki.mozilla.org/Bugzilla:BzAPI:CompatLayer
[Comment previews]: http://globau.wordpress.com/2014/02/14/markup-within-bugzilla-comments/
[Better tracking of reviews]: https://bugzilla.mozilla.org/show_bug.cgi?id=956229
[UI]: https://bugzilla.mozilla.org/show_bug.cgi?id=1021902
[Whiteboard tags]: https://wiki.mozilla.org/BMO/Whiteboard
[proper mentor field]: https://bugzilla.mozilla.org/show_bug.cgi?id=649691
[My Dashboard]: https://bugzilla.mozilla.org/page.cgi?id=mydashboard.html
[Read more]: http://globau.wordpress.com/2014/06/04/bugzilla-can-now-show-bugs-that-have-been-updated-since-you-last-visited-them/
[bugmail filtering]: http://globau.wordpress.com/2014/07/10/using-bugmail-filtering-to-exclude-notifications-you-dont-want/
[current goals and high-priority items]: https://wiki.mozilla.org/BMO#Current_Projects


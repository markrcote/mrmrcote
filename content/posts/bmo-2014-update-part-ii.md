---
title: "BMO 2014 update part II"
date: 2015-01-07T14:31:30-05:00
categories: ["mozilla", "bmo", "bugzilla"]
---
The second half of 2014 was spent finishing up some performance work
and shifting into usability improvements, which will continue into
2015.

More performance!
=================

By the end of 2014, we'd managed to pick most of the low-to-medium-hanging
fruit in the world of Bugzilla server-side performance.  The result is
approximately doubling the performance of authenticated bug views.
Here are graphs from January 2014 and October 2014:

<img src="/images/bmo-cgi-perf-jan-oct-2014.png">

The server now also minifies and concatenates [JavaScript][] and [CSS][]
files.  This affects cold loads mostly, since these files are cached,
but even on reload it saves a few round trips.

As mentioned above, we're shifting focus away from performance work
and towards usability/work-flow improvements, but there will still be
perf benefits, both by reducing and delaying loading of content and by
making it easier for users to accomplish common tasks.

New, better documentation
=========================

We've converted the upstream Bugzilla [documentation][] to
reStructuredText, massively updated and reorganized it, and, perhaps
of most interest to anyone reading this, completely rewrote the
[API docs][], which were very hard to grok.

For BMO specifically, we've fixed up the [wiki page][]. We've also
started a [user guide][], but it's just a skeleton at the moment.
There are lots of users out there who know the ins and outs of BMO, so
feel free to contribute a section!

GMail support
=============

To support Mozilla's transition to GMail, we added two features.
First, we now [limit][] the number of emails sent to a user per minute
and per hour, since GMail will temporarily disable accounts that
receive too much mail, and some BMO users receive *a lot* of bugmail.
Second, since GMail's ability to filter mail by headers is limited
compared to other email servers, users can now include the
X-Bugzilla-* [headers in the body][] via [General Preferences][].

Other things
============

* When [entering a new bug][], after selecting the product, any
  relevant custom bug-entry forms are now displayed at the top of the
  form. We also added a [full list][] of all the custom forms in BMO
  (linked at the bottom of the bug-entry landing page).

* There's now a UI for your [Review History][] (as reviewer).

* BMO now uses the [Fira Sans typeface][] to improve consistency with
  other Mozilla web properties, although we [reverted][] to the old
  monospace style after a lot of negative feedback about Fira's
  monospace. If you don't like Fira, you can always switch to OpenSans
  by changing your skin in the [General Preferences][].

* [My Dashboard][] now has an "Interesting Bugs" query. You can see a
  full description of the bug criteria in the [bug's user story][],
  but in effect it should be close to what you would receive in
  bugmail.   This is useful on its own if you don't want to rely on
  bugmail, but we have plans to make it even more useful by adding
  [weighted scoring][] to order bugs according to how relevant the
  changes are to you in particular.

* There's now an easy way to [generate a shortened link][] for
  search URLs, which tend to be long.

* And just landed yesterday, which is technically 2015 but the result
  of work done in 2014, is a new look for the [guided bug-entry form][],
  aka the Bugzilla Helper, which new BMO users get by default
  when filing new bugs. It's the first step of a [series of improvements][]
  intended to make it easier for new users to file good bugs.

2015!
=====

As I've said a few times now, in 2015 we're going to do a lot of work
on improving general BMO-user productivity: usability, UX, work flows,
whatever you want to call it.  I'll write more about this later, but
here are a few things we're looking into:

* Experimenting with [alternative][] bug views. There's a lot of stuff
  on the standard bug view. Can we give different windows into the
  data depending on what the user is trying to accomplish? Can we load
  this data more intelligently, and organize it more intuitively?

* A [proper field][] for [MozReview][] links that dynamically loads and
  displays state information on the review request.

* [Authentication via GitHub][]. A lot of Mozilla projects are on
  GitHub, but many use Bugzilla for issue tracking. To make it easier
  for contributors coming to us via GitHub, we'll let them log into
  Bugzilla using their GitHub account.

* As I wrote about in an earlier post, [improved searchability][].

As usual, if you have questions or comments, you can leave them here,
but an even better place is the mozilla.tools.bmo [mailing list][],
also available as a [Google Group][] and via [NNTP][].

[JavaScript]: https://bugzilla.mozilla.org/show_bug.cgi?id=1064395
[CSS]: https://bugzilla.mozilla.org/show_bug.cgi?id=977969
[documentation]: http://bugzilla.readthedocs.org/en/latest/index.html
[API docs]: http://bugzilla.readthedocs.org/en/latest/api/index.html
[wiki page]: https://wiki.mozilla.org/BMO
[user guide]: https://wiki.mozilla.org/BMO/UserGuide
[limit]: https://bugzilla.mozilla.org/show_bug.cgi?id=1062739
[headers in the body]: https://wiki.mozilla.org/Bugzilla:FAQ:Filtering_Bugzilla_Email_In_Gmail
[General Preferences]: https://bugzilla.mozilla.org/userprefs.cgi
[entering a new bug]: https://bugzilla.mozilla.org/enter_bug.cgi
[full list]: https://bugzilla.mozilla.org/page.cgi?id=custom_forms.html
[Review History]: https://bugzilla.mozilla.org/page.cgi?id=review_history.html
[Fira Sans typeface]: https://www.mozilla.org/en-US/styleguide/products/firefox-os/typeface/
[reverted]: https://bugzilla.mozilla.org/show_bug.cgi?id=1038808
[My Dashboard]: https://bugzilla.mozilla.org/page.cgi?id=mydashboard.html
[bug's user story]: https://bugzilla.mozilla.org/show_bug.cgi?id=1074586
[weighted scoring]: https://bugzilla.mozilla.org/show_bug.cgi?id=1074589
[generate a shortened link]: https://globau.wordpress.com/2014/09/02/happy-bmo-push-day-111/
[guided bug-entry form]: https://bugzilla.mozilla.org/enter_bug.cgi?format=guided
[series of improvements]: https://bugzilla.mozilla.org/show_bug.cgi?id=1080933
[alternative]: https://bugzilla.mozilla.org/show_bug.cgi?id=1068655
[proper field]: https://bugzilla.mozilla.org/show_bug.cgi?id=1102428
[MozReview]: http://mozilla-version-control-tools.readthedocs.org/en/latest/mozreview-user.html
[Authentication via GitHub]: https://bugzilla.mozilla.org/show_bug.cgi?id=1118365
[improved searchability]: /blog/2014/12/17/searching-bugzilla/
[mailing list]: https://lists.mozilla.org/listinfo/tools-bmo
[Google Group]: https://groups.google.com/forum/#!forum/mozilla.tools.bmo
[NNTP]: news://news.mozilla.org:119/mozilla.tools.bmo

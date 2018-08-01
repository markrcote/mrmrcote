---
title: "BMO in 2013"
date: 2014-01-03T11:20:33-05:00
categories: ["mozilla", "bmo"]
---
2013 was a pretty big year for [BMO][]!  I covered a bit in my [last post][]
on BMO, but I want to sum up just some of the things that the
team accomplished in 2013 as well as to give you a preview of a
few things to come.

We push updates to BMO generally on a weekly basis.  The changelog for
each push is posted to [glob's blog][] and linked to from Twitter
([@globau][]) and from BMO's discussion forum, mozilla.tools.bmo
(available via [mailing list][], [Google Group][], and [USENET][]).

I'm leaving comments open, but if you have something to discuss,
please bring it to mozilla.tools.bmo.


Stats for 2013
--------------

#### BMO Usage:

35&thinsp;190 new users registered<br/>
130&thinsp;385 new bugs filed<br/>
107&thinsp;884 bugs resolved


#### BMO Development:

115 code pushes<br/>
1&thinsp;202 new bugs filed<br/>
1&thinsp;062 bugs resolved


Native REST API
---------------

2013 saw a big investment in making Bugzilla a platform, not just a
tool, for feature and defect tracking (and the other myriad things
people use it for!).  We completed a native [RESTish API][] to
complement the antiquated XMLRPC, JSONRPC, and JSONP interfaces.  More
importantly, we've built out this API to support more and more
functionality, such as logging in with tokens, adding and updating
flags, and querying the permissions layer.

Something worth taking note of is the [bzAPI compatibility layer][],
which will be deployed in early Q1 of 2014.  [bzAPI] is a nice
application which implements a REST interface to Bugzilla through a
combination of the legacy APIs, CSV renderings, and screen-scraped
HTML.  It is, however, essentially a proxy service to Bugzilla, so it
has both limited functionality and poorer performance than a native
API.  With the new bzAPI compatibility layer, site admins will just
have to change a URL to take advantage of the faster built-in REST
API.

We are also planning to take the best ideas from the old APIs, bzAPI,
the newly added functionality, and modern REST interfaces to produce
an awesome version 2.0.


Project Kick-off Form
---------------------

The [Project Kick-off Form][] that was conceived and driven by Michael
Coates was launched in January.  The BMO team implemented the whole
thing in the preceding months and did various improvements over the
course of 2013.

The Form is now in the very capable hands of Winnie Aoieong.  Winnie
did a [Project Kick-Off Refresher Brown Bag][] last month if you want,
well, a refresher.  We'll be doing more to support this tool in 2014.


Sandstone Skin
--------------

BMO finally got a new default look this year.  This was the result of
some ideas from the "Bugzilla pretty" contest, the Mozilla
[Sandstone][] style guide, and our own research and intuition.  BMO is
still a far cry from a slick Web 2.x (or are we at 3.0 yet?) site, but
it's a small step towards it.

Oh and we have [Gravatar support][] now!


User Profiles
-------------

Want to get some quick stats about a Bugzilla user&mdash;how long
they've been using Bugzilla, the length of their review queue, or the
areas in which they've been active?  Click on a user's name and select
"Profile", or go directly to your [user profile page][] and enter a
name or email into the search field.

File bugs under [bugzilla.mozilla.org :: Extensions: UserProfile][] if
there are other stats you think might be useful.


Review Suggestions and Reminders
--------------------------------

Code reviews were a big topic at Mozilla in 2013. The BMO team
implemented a couple related features:

* [Reviewer suggestions][]: When you are flagging a patch for review,
  you are now presented with a link to a list of one or more suggested
  reviewers according to the bug's product and component. This is
  useful for new contributors who won't necessarily know who would
  make a good candidate for review. Given beside the username is the
  number of reviews in that person's queue, to encourage spreading
  reviews out.

* [Review notifications][]: As a result of a [discussion on code reviews][]
  on dev.planning, by default you now get daily emails
  about your open reviews. You can also subscribe to these
  notifications for any Bugzilla user, something particularly useful
  to managers. As a bonus feature, you also get the number of requests
  assigned to you presented in a small red circle at the top of every
  Bugzilla page.


System Upgrade
--------------

When we upgraded&dagger; [BMO to Bugzilla 4.2], IT also moved BMO from older
hardware in Phoenix to new, faster hardware in SCL3.  BMO was then
set up anew in Phoenix and is now the failover location in case of an
outage in SCL3.

&dagger; The BMO team regularly backports particularly useful patches
from later upstream Bugzilla versions and trunk, but we fully upgraded
to version 4.2 in the spring of 2013.


Other Stuff
-----------

We added [user][] and [product dashboards][], implemented [comment tagging][],
[improved bug update times][], and added redirects for
[GitHub pull-request reviews][].

And then there were various bits of internal plumbing largely (by
design!) invisible to users, such as the great [tracking-flags migration][];
tonnes of little fixes here and there; and of course daily administration.


Plans for 2014
--------------

We're already at work planning and implementing new features to start
2014 off right.

* The [Bugzilla Change Notification System][] will be
  [deployed to production][].  This will allow external applications
  (and eventually the native UI) to subscribe to one or more bugs via
  Web Sockets and be notified when they change.

* [Performance instrumentation][] will be integrated into BMO (and
  upstream Bugzilla) to provide profiling data.  Bugzilla's been around
  for quite some time and, in supporting various complex workflows, its
  operations in turn can be quite involved. We'll use data provided by
  this system to determine where we should focus optimization work.

* We [added memcached support][] to Bugzilla in Q4 of 2013; this will
  be pushed to BMO early in Q1 of 2014. Initially BMO will only use
  memcached for a few objects, but we'll be [adding more][] over time.

* We're setting up [ElasticSearch clusters][] to provide a different
  way to access Bugzilla data, suitable for dashboards and general
  research.

* Code reviews are a continued focus at Mozilla, so we're implementing
  a way to get authoritative, comprehensive [review data][] directly
  from BMO.

Our quarterly goals and other major work items are tracked on the
[BMO wiki page][]. You can also check out our [road map][] for some vague
ideas of plans into the future; these are ideas based on our current
understanding of the Mozillaverse and will almost certainly change to
some degree.


[mailing list]: https://lists.mozilla.org/listinfo/tools-bmo
[Google Group]: https://groups.google.com/forum/#!forum/mozilla.tools.bmo
[USENET]: news://news.mozilla.org:119/mozilla.tools.bmo
[@globau]: https://twitter.com/globau
[BMO]: https://bugzilla.mozilla.org/
[last post]: /blog/2013/08/15/mid-august-bmo-news/
[glob's blog]: http://blog.glob.com.au/
[RESTish API]: http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Server/REST.html
[Project Kick-off Form]: https://wiki.mozilla.org/Websites/Kick-Off_Form
[Project Kick-Off Refresher Brown Bag]: https://air.mozilla.org/project-kick-off-refresher-brown-bag/
[Sandstone]: http://www.mozilla.org/en-US/styleguide/websites/sandstone/
[Gravatar support]: https://bugzilla.mozilla.org/show_bug.cgi?id=903955
[bzAPI compatibility layer]: https://bugzilla.mozilla.org/show_bug.cgi?id=880669
[bzAPI]: https://wiki.mozilla.org/Bugzilla:REST_API
[user profile page]: https://bugzilla.mozilla.org/user_profile
[bugzilla.mozilla.org :: Extensions: UserProfile]: https://bugzilla.mozilla.org/enter_bug.cgi?product=bugzilla.mozilla.org&component=Extensions%3A%20UserProfile
[discussion on code reviews]: https://groups.google.com/forum/#!searchin/mozilla.dev.platform/24hour$20review/mozilla.dev.platform/UCio5fB4VJo/PGnLqgMlHokJ
[user]: https://bugzilla.mozilla.org/page.cgi?id=mydashboard.html
[product dashboards]: https://bugzilla.mozilla.org/page.cgi?id=productdashboard.html
[comment tagging]: http://blog.glob.com.au/2013/12/11/comment-tagging-deployed-to-bmo/
[improved bug update times]: http://blog.glob.com.au/2013/11/20/improving-bug-update-times/
[Review notifications]: http://blog.glob.com.au/2013/10/30/nightly-request-reminders/
[Reviewer suggestions]: https://bugzilla.mozilla.org/show_bug.cgi?id=804708
[GitHub pull-request reviews]: http://blog.glob.com.au/2013/10/21/github-pull-requests-and-bugzilla/
[tracking-flags migration]: https://wiki.mozilla.org/BMO/TrackingFlags
[BMO to Bugzilla 4.2]: http://blog.glob.com.au/2013/03/14/bugzilla-mozilla-org-upgraded-to-v4-2/
[Bugzilla Change Notification System]: https://wiki.mozilla.org/BMO/ChangeNotificationSystem
[deployed to production]: https://bugzilla.mozilla.org/show_bug.cgi?id=952880
[Performance instrumentation]: https://bugzilla.mozilla.org/show_bug.cgi?id=956230
[added memcached support]: https://bugzilla.mozilla.org/show_bug.cgi?id=237498
[adding more]: https://bugzilla.mozilla.org/show_bug.cgi?id=956233
[ElasticSearch clusters]: https://wiki.mozilla.org/Auto-tools/Projects/PublicES
[review data]: https://bugzilla.mozilla.org/show_bug.cgi?id=956229
[BMO wiki page]: https://wiki.mozilla.org/BMO
[road map]: https://wiki.mozilla.org/BMO/Roadmap_2014

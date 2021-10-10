---
title: "Phabricator Update"
date: 2017-07-11T16:24:22-04:00
categories: ["mozilla", "conduit"]
---
tl;dr

* Development Phabricator instance is up at
<https://mozphab.dev.mozaws.net/>, authenticated via
bugzilla-dev.allizom.org.
* Development, read-only UI for Lando (the new automatic-landing
service) has been deployed.
* Work is proceeding on matching viewing restrictions on Phabricator
revisions (review requests) to associated confidential bugs.
* Work is proceeding on the internals of Lando to land Phabricator
revisions to the autoland Mercurial branch.
* Pre-release of Phabricator, without Lando, targeted for mid-August.
* General release of Phabricator and Lando targeted for late September
or early October.
* MozReview and Splinter turned off in early December.

--------

Work on *Phabricator@Mozilla* has been progressing well for the last
couple months. Work has been split into two areas:
Phabricator–Bugzilla integration and automatic landings.

Let me start with what's live today:

Our Phabricator development instance is up at
<https://mozphab.dev.mozaws.net/>. We've completed and deployed a
Phabricator extension to use Bugzilla for authentication and identity;
on our mozphab.dev instance, this is tied to
bugzilla-dev.allizom.org. If you would like to poke around our
development instance, please be our guest! Note that it *is* a
development server, so we make no guarantees as to functionality, data
preservation, and such, as with bugzilla-dev. Also, if you
haven't used bugzilla-dev in the last year or two (or ever), you'll
either need to log in with GitHub or get an admin to reset your
password, since email is disabled on this server. Ping mcote or holler
in #bmo on IRC. I'll have a follow-up post on exactly what's involved in
using Bugzilla as an authentication and identity provider and how it
affects you.

The skeleton of our new automatic-landing service, called Lando, is
also deployed to development servers. While it doesn't actually do any
landings yet, the UI has been fleshed out. It pulls the current status
of a "revision" (which is Phabricator's term for a review request) and
displays relevant details. It is currently pulling live data from
mozphab.dev. This is what it looks like at the moment, although we
will continue to iterate on it:

![Lando 20170710](/images/lando-20170710.png)

What we're working on now:

The other part of Bugzilla integration is ensuring that we can support
confidential revisions (review requests) in Phabricator tied to
confidential bugs in a seamless way. The goal is to have the set of
people who can view a confidential bug in Bugzilla be equal to the set
of people who can view any Phabricator revisions associated with that
bug. We knew that matching any third-party tool to Bugzilla's
fine-grained authorization system would not be easy, but Phabricator
has proven even trickier to integrate than we anticipated. We have
implemented the code that sets the visibility appropriately for a new
revision, and we have the skeleton code for keeping it in sync, but
there are some holes in our implementation that we need to plug. We're
continuing to dig into this and have set a goal to have a solid plan
within two weeks, with implementation to follow immediately.

In parallel, within Lando we are working on the logic to take a diff
from a Phabricator revision, verify the lander's credentials and
permissions, and turn it into a commit on the autoland branch of
hg.mozilla.org. We have much of the first point done now, are
consulting with IT on the best solution for the second, and will be
starting work on the third shortly (which is actually the easiest,
since we're leveraging pieces of MozReview's Autoland service).

Launch plans:

At the point that we have completed the Bugzilla-integration work
described above, we'll have what we need for a production Phabricator
environment integrated with Bugzilla. This is planned for
mid-August. We are calling this our pre-release launch, as Lando will
not be complete, but we will be inviting some teams to try out
Phabricator, to catch issues and frustrations before going to general
release. Lando and the general rollout of Phabricator to all Firefox
enginering will follow in late September or early October. We'll have
some brownbags to introduce Phabricator and our integrations, and we
will ensure documentation is available and discoverable both for
general Phabricator usage and our customizations, including automatic
landings.

Due to the importance of the Firefox 57 release, Splinter and
MozReview will remain functional but will be considered
deprecated. New contributors should be directed to Phabricator to
avoid the frustration of having to switch processes. Splinter will be
turned off and MozReview will be moved to a read-only mode in early
December.

More updates to follow!

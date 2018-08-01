---
title: "Project Isolation"
date: 2015-05-17T22:37:51-04:00
categories: ["mozilla"]
---
The other day I read about another new Mozilla project that decided to
[go with GitHub issues][] instead of our Bugzilla installation (BMO).
The author's arguments make a lot of sense: GitHub issues are much
simpler and faster, and if you keep your code in GitHub, you get
tighter integration.  The author notes that a downside is the
inability to file security or confidential bugs, for which Bugzilla
has a fine-grained permission system, and that he'd just put those
(rare) issues on BMO.

The one downside he doesn't mention is interdependencies with other
Mozilla projects, e.g. the Depends On/Blocks fields.  This
is where Bugzilla gets into project, product, and perhaps even program
management by allowing people to easily track dependency chains, which
is invaluable in planning.  Many people actually file bugs solely as
trackers for a particular feature or project, hanging all the work
items and bugs off of it, and sometimes that work crosses product
boundaries.  There are also a number of tracking flags and fields that
managers use to prioritize work and decide which releases to target.

If I had to rebut my own point, I would argue that the projects that
use GitHub issues are relatively isolated, and so dependency tracking
is not particularly important.  Why clutter up and slow down the UI
with lots of features that I don't need for my project?  In
particular, most of the tracking features are currently used only by,
and thus designed for, the Firefox products (aside: this is one reason
the new modal UI hides most of these fields by default if they have
never been set).

This seems hard to refute, and I certainly wouldn't want to force an
admittedly complex tool on anyone who had much simpler needs.  But
something still wasn't sitting right with me, and it took a while to
figure out what it was.  As usual, it was that a different question
was going unasked, leading to unspoken assumptions: *why* do we have
so many isolated projects, and what are we giving up by having such
loose (or even no) integration amongst all our work?

Working on projects in isolation is comforting because you don't have
to think about all the other things going on in your organization--in
other words, you don't have to communicate with very many people.  A
lack of communication, however, leads to several problems:

* low visibility: what is everyone working on?
* redundancy: how many times are we solving the same problem?
* barriers to coordination: how can we become greater than the sum of
  our parts by delivering inter-related features and products?

By working in isolation, we can't leverage each other's strengths and
accomplishments.  We waste effort and lose great opportunities to
deliver amazing things.  We know that places like Twitter use
monorepos to get some of these benefits, like a single
build/test/deploy toolchain and coordination of breaking changes.  This
is what facilitates architectures like microservices and SOAs.  Even
if we don't want to go down those paths, there is still a clear
benefit to program management by at least integrating the tracking and
planning of all of our various endeavours and directions.  We need
better organization-wide coordination.

We're already taking some steps in this direction, like moving Firefox
and Cloud Services to one division.  But there are many other teams
that could benefit from better integration, many teams that are
duplicating effort and missing out on chances to work together.  It's
a huge effort, but maybe we need to form a team to define a strategy
and process--a Strategic Integration Team perhaps?

[go with GitHub issues]: http://www.agmweb.ca/2015-05-11-ditching-bugzilla/

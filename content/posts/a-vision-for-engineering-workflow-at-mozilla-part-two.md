---
title: "A Vision for Engineering Workflow at Mozilla (Part Two)"
date: 2018-07-05T10:01:39-04:00
categories: ["mozilla"]
---
In my [last post][] I touched on the history and mission of the
Engineering Workflow team, and I went into some of the challenges the
team faces, which informed the creation of the team's vision.  In this
post I'll go into the vision itself.

First, a bit of a preamble to set context and expectations.

About the Vision
================

Members of the Engineering Workflow team have had many conversations
with Firefox engineers, managers, and leaders across many years.  The
results of these conversations have led to various product decisions,
but generally without a well-defined overarching direction.  Over the
last year we took a step back to get a more comprehensive
understanding of the needs and inefficiencies in Firefox engineering.
This enables us to lay out a map of where Engineering Workflow could
go over the course of years, rather than our previous short-term
approaches.

As I mentioned earlier, I couldn't find much in the way of examples of
tooling strategies to work from.  However, there are many projects out
there that have developed tooling and automation ecosystems that can
provide ideas for us to incorporate into our vision.  A notable
example is the Chromium project, the open-source core of the Chrome
browser.  Aspects of their engineering processes and systems have made
their way into what follows.

It is very important to understand that this vision, if not
vision statements in general, is *aspirational*.  I deliberately
crafted it such that it could take many engineer-years to achieve even
a large part of it.  It should be something we can reference to guide
our work for the foreseeable future.  To ensure it was as
comprehensive as possible, it was constructed without attention given
to feasibility nor, therefore, the priority of its individual
pieces.  A road map for how to best approach the implementation of the
vision for the most impact is a necessary next step.

The resulting vision is nine points laying out the ideal world from an
Engineering Workflow standpoint.  I'll go through them one by one up
to point four in this post, with the remaining five to follow.

The Engineering Workflow Vision
===============================

1\. Checking out the full mozilla-central source is fast
-------------------------------------------------------

The repository necessary for building and testing Firefox,
[mozilla-central][], is massive.  Cloning and updating the repo takes
quite a while even for engineers located close by the central
hg.mozilla.org servers; the experience for more distant contributors
can be much worse.  Furthermore, this affects our CI systems, which
are constantly cloning the source to execute builds and tests.  Thus
there is a big benefit to making cloning and updating the Firefox
source as fast as possible.

There are various ways to tackle this problem.  We are currently
working on geo-distributed mirrors of the source code that are at
least read-only to minimize the distance the data has to travel to get
onto your local machine.  There is also work we can do to reduce the
amount of data that needs to be fetched, by determining what data is
actually required for a given task and using that to allow shallow
and/or narrow clones.

There are other issues in the VCS space that hamper the productivity
of both product and tooling engineers.  One is our approach to
branching.  The various [train][], feature, and testing branches are
in fact separate repositories altogether, stemming from the early days
of the switch to Mercurial.  This nonstandard approach is both
confusing and inefficient.  There are also multiple integration
"branches", in particular autoland and mozilla-inbound, which require
regular merging which in turn complicates history.

Supporting multiple VCSes also has a cost.  Although Mercurial is the
core VCS for Firefox development, the rise of Git led to the
development of [git-cinnabar][] as an alternate avenue to interacting
with Firefox source.  If not a completely *de juror* solution, it has
enough users to warrant support from our tools, which means extra
work.  Furthermore, it is still sufficiently different from Git, in
terms of installation at least, to trip some contributors up.
Ideally, we would have a single VCS in use throughout Firefox
engineering, or at least a well-defined pipeline for contributions
that allows smooth use of vanilla Git even if the core is still kept
in Mercurial.

2\. Source code and history is easily navigable
----------------------------------------------

To continue from the previous point, the vast size of the Firefox
codebase means that it can be quite tricky for even experienced
engineers, let alone new contributors, to find their way around.  To
reduce this burden, we can both improve the way the source is laid out
and support tools to make sense of the whole.

One confusing aspect of mozilla-central is the lack of organization
and discoverability of the many third-party libraries and applications
that are mirrored in.  It is difficult to even figure out what is
externally sourced, let alone how and how often our versions are
updated.  We have started a plan to [provide metadata][] and
reorganize the tree to make this more discoverable, with the eventual
goal to automate some of the manual processes for updating third-party
code.

Mozilla also has not just one but two tools for digging deep into
Firefox source code: [dxr][] and [searchfox][].  Neither of these
tools are well maintained at the moment.  We need to critically
examine these, and perhaps other, tools and choose a single solution,
again improving discoverability and maintainability.

3\. Installing a development environment is fast and easy
--------------------------------------------------------

Over the years Mozilla engineers have developed solutions to simplify
the installation of all the applications and libraries necessary to
build Firefox that aren't bundled into its codebase.  Although they
work relatively well, there are many improvements that can be made.

The rise of Docker and other container solutions has resulted in an
appreciation of the benefits of isolating applications from the
underlying system.  Especially given the low cost of disk space today,
a Firefox build and test environment should be completely isolated
from the rest of the host system, preventing unwanted interactions
between other versions of dependent apps and libraries that may
already be installed on the system, and other such
cross-contamination.

We can also continue down the path that was started with [mach][] and
encapsulate other common tasks in simple commands.  Contributors
should not have to be familiar with the intricacies of all of our
tools, in-house and third-party, to perform standard actions like
building, running tests, submitting code reviews, and landing patches.

4\. Building is fast
-------------------

Building Firefox is a task that individual developers perform all the
time, and our CI systems spend a large part of their time doing the
same.  It should be pretty obvious that reducing the time to build
Firefox with a code change anywhere in the tree has a serious impact.

There are myriad ways our builds can be made faster.  We have already
done a lot of work to abstract build definitions in order to
experiment with different build systems, and it looks like [tup][] may
allow us to have [lightning-fast][] incremental builds.  Also, the
strategy we used to isolate platform components written in C++ and
Rust from the front-end JavaScript pieces, which dramatically lowered
build times for people working on the latter, could similarly be
applied to isolate the building of system add-ons, such as devtools,
from the rest of Firefox.  We should do a comprehensive evaluation of
places existing processes can be tightened up and continue to look for
where we can make larger changes.

Stay tuned for the final part of this series of posts.

[last post]: /blog/2018/05/31/a-vision-for-engineering-workflow-at-mozilla-part-one/
[mozilla-central]: https://hg.mozilla.org/mozilla-central
[train]: https://wiki.mozilla.org/Release_Management/Release_Process
[git-cinnabar]: https://github.com/glandium/git-cinnabar
[provide metadata]: https://bugzilla.mozilla.org/show_bug.cgi?id=1454867
[dxr]: https://dxr.mozilla.org/
[searchfox]: https://searchfox.org/
[mach]: https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/mach
[tup]: http://gittup.org/tup/
[lightning-fast]: https://docs.google.com/presentation/d/1SHb9Vp0aWPbHz1Eo53h9Xbh4-6qmukSknFQXQc2BVqA/edit

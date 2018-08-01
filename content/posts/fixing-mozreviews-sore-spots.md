---
title: "Fixing MozReview's sore spots"
date: 2015-09-30T14:15:01-04:00
categories: ["mozilla", "mozreview"]
---
MozReview was intentionally released early, with a fairly minimal
feature set, and some ugly things bolted onto a packaged code-review
tool.  The code-review process at Mozilla hasn't changed much since
the project began—Splinter, a slightly fancier UI than dealing with
raw diffs, notwithstanding.  We knew this would be a controversial
subject, with a variety of (invariably strong) opinions.  But we also
knew that we couldn't make meaningful progress on a number of
long-desired features, like autolanding commits and automatic code
analysis, without moving to a modern repository-based review system.
We also knew that, with the incredible popularity of GitHub, many
developers expect a workflow that involves them pushing up commits for
review in a rich web UI, not exporting discrete patches and looking at
almost raw diffs.

Rather than spending a couple years off in isolation developing a
polished system that might not hit our goals of both appealing to
future Mozillians and increasing productivity overall, we released a
very early product—the basic set of features required by a push-based,
repository-centric code-review system.  Ironically, perhaps, this has
*decreased* the productivity of some people, since the new system is
somewhat raw and most definitely a big change from the old.  It's our
sincere belief that the pain currently experienced by some people,
while definitely regrettable and in some cases unexpected, will be
balanced, in the long run, by the opportunities to regularly correct
our course and reach the goal of a world-class code
review-and-submission system that much faster.

And so, as expected, we've received quite a bit of feedback.  I've
been noticing a pattern, which is great, because it gives us insight
into classes of problems and needs.  I've identified four categories,
which interestingly correspond to levels of usage, from basic to
advanced.

Understanding MozReview's (and Review Board's) models
-----------------------------------------------------

Some users find MozReview very opaque.  They aren't sure what many of
the buttons and widgets do, and, in general, are confused by the
interface.  This caught us a little off-guard but, in retrospect, is
understandable.  Review Board is a big change from Splinter and much
more complex.  I believe one of the sources of most confusion is the
overall review model, with its various states, views, entry points,
and exit points.  Splinter has the concept of a review in progress,
but it is a lot simpler.

We also had to add the concept of a series of related commits to
Review Board, which on its own has essentially a patch-based model,
similar to Splinter's, that's too limited to build on.  The
relationship between a parent review request and the individual
"child" commits is the source of a lot of bewilderment.

Improving the overall user experience of performing a review is a top
priority for the next quarter.  I'll explore the combination of the
complexity of Review Board and the commit-series model we added in a
follow-up post.

Inconveniences and lack of clarity around some features
-------------------------------------------------------

For users who are generally satisfied by MozReview, at least, enough
to use it without getting too frustrated, there are a number of paper
cuts and limitations that can be worked around but generate some
annoyance.  This is an area we knew we were going to have to improve.
We don't yet have parity with Splinter/Bugzilla attachments,
e.g. reviewers can't delegate review requests, nor can they mark
specific files as reviewed.  There are other areas that we can go
beyond Bugzilla, such as being able to land parts of a commit series
(this is technically possible in Bugzilla by having separate patches,
but it's difficult to track).  And there are specific things that
Review Board has that aren't as useful for us as they could be, like
the dashboard.

This will also be a big part of the work in the next quarter (at least).

Inability to use MozReview at all due to technological limitations
------------------------------------------------------------------

The single biggest item here is lack of support for git, particularly
a git interface for hg repos like mozilla-central.  There are many
people interested in using MozReview, but their work flows are based
around git using git-cinnabar.  gps and kanru did some initial work
around this in [bug 1153053][]; fleshing this out into a proper
solution isn't a small task, but it seems clear that we'll have to
finish it regardless before too long, if we want MozReview to be the
central code-review tool at Mozilla.  We're still trying to decide how
this fits into the above priorities; more users is good, but making
existing users happier is as well.

Big-ticket items
----------------

As mentioned at the beginning of this post, the main reason we're
building a new review tool is to make it repository-centric, that is,
based around commits, not isolated patches.  This makes a lot of
long-desired tools and features much more feasible, including
autoland, automatic static analysis, commit rewriting to automatically
include metadata like reviewers, and a bunch of other things.

This has been a big focus for the last few months.  We've had
autoland-to-try for a little while now, and autoland-to-inbound is
nearly complete.  We have a generic library for static analysis with
which we'll be able to build various review bots.  And, of course, the
one big feature we started with, the ability push commits to MozReview
instead of exporting standalone patches, which by itself is both more
convenient and preserves more information.

After autoland-to-inbound we'll be putting aside other big features
for a little while to concentrate on general user experience so that
people enjoy using MozReview, but rest assured we'll be back here to
build more powerful workflows for everyone.

[bug 1153053]: https://bugzilla.mozilla.org/show_bug.cgi?id=1153053
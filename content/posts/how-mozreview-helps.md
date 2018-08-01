---
title: "How MozReview helps"
date: 2016-04-22T11:39:59-04:00
categories: ["mozilla", "mozreview"]
---
A great [post on code review][] is making its rounds.  It's started
some discussion amongst Mozillians, and it got me thinking about how
MozReview helps with the author's points.  It's particularly
interesting because apparently Twitter uses Review Board for code
reviews, which is a core element of the whole MozReview system.

The author notes that it's very important for reviewers to know what
reviews are waiting on them, but also that Review Board itself doesn't
do a good job of this.  MozReview fixes this problem by piggybacking
on Bugzilla's review flags, which have a number of features built
around them: indicators, dashboards, notification emails, and reminder
emails.  People can even subscribe to the reminders for other
reviewers; this is a way managers can ensure that
their teams are responding promptly to review requests.  We've also
toyed around with the idea of using push notifications to notify
people currently using Bugzilla that they have a new request (also
relevant to the section on being "interrupt-driven").

On the submitter side, MozReview's core support for [microcommits][]—a
feature we built on top of Review Board, within our extensions—helps
"keep reviews as small as possible".  While it's impossible to enforce
small commits within a tool, we've tried to make it as painless as
possible to split up work into a series of small changes.

The MozReview team has made progress on automated static analysis
(linters and the like), which helps submitters verify that their
commits follow stylistic rules and other such conventions.  It will
also shorten review time, as the reviewer will not have to spend time
pointing out these issues; when the review bots have given their r+s,
the reviewer will be able to focus solely on the logic.  As we
continue to grow the MozReview team, we'll be devoting some time to
finishing up this feature.


[post on code review]: http://glen.nu/ramblings/oncodereview.php
[microcommits]: http://mozilla-version-control-tools.readthedocs.org/en/latest/mozreview/commits.html#prefer-more-smaller-commits-over-large-monolithic-commits

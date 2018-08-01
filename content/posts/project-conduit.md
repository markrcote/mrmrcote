---
title: "Project Conduit"
date: 2017-01-13T12:56:20-05:00
categories: ["mozilla", "mozreview", "conduit"]
---
In 2017, [Engineering Productivity][] is starting on a new project that
we're calling "Conduit", which will improve the automation around
submitting, testing, reviewing, and landing commits.  In many ways,
Conduit is an evolution and course correction of the work on MozReview
we've done in the last couple years.

Before I get into what Conduit is exactly, I want to first clarify
that the MozReview team has not really been working on a review tool
per se, aside from some customizations requested by users (line
support for inline diff comments).  Rather, most of our work was
building a whole pipeline of automation related to getting code
landed.  This is where we've had the most success: allowing
developers to push commits up to a review tool and to easily land them
on try or mozilla-central.  Unfortunately, by naming the project
"MozReview" we put the emphasis on the review tool (Review Board)
instead of the other pieces of automation, which are the parts unique
to Firefox's engineering processes.  In fact, the review tool should
be a replaceable part of our whole system, which I'll get to shortly.

We originally selected Review Board as our new review tool for a few
reasons:

* The back end is Python/Django, and our team has a lot of experience
  working with both.

* The diff viewer has a number of fancy features, like clearly
  indicating moved code blocks and indentation changes.

* A few people at Mozilla had previously contributed to the Review
  Board project and thus knew its internals fairly well.

However, we've since realized that Review Board has some big
downsides, at least with regards to Mozilla's engineering needs:

* The UI can be confusing, particularly in how it separates the Diff
  and the Reviews views.  The Reviews view in particular has some
  usability issues.

* Loading large diffs is slow, but also conversely it's unable to
  depaginate, so long diffs are always split across pages.  This
  restricts the ability to search within diffs.  Also, it's impossible
  to view diffs file by file.

* Bugs in interdiffs and even occasionally in the diffs themselves.

* No offline support.

In addition, the direction that the upstream project is taking is not
really in line with what our users are looking for in a review tool.

So, we're taking a step back and evaluating our review-tool
requirements, and whether they would be best met with another tool or
by a small set of focussed improvements to Review Board.  Meanwhile,
we need to decouple some pieces of MozReview so that we can accelerate
improvements to our productivity services, like Autoland, and ensure
that they will be useful no matter what review tool we go with.
Project Conduit is all about building a flexible set of services that
will let us focus on improving the overall experience of submitting
code to Firefox (and some other projects) and unburden us from the
restrictions of working within Review Board's extension system.

In order to prove that our system can be independent of review tool,
and to give developers who aren't happy with Review Board access to
Autoland, our first milestone will be hooking the commit repo (the
push-to-review feature) and Autoland up to BMO.  Developers will be
able to push a series of one or more commits to the review repo, and
reviewers will be able to choose to review them either in BMO or
Review Board.  The Autoland UI will be split off into its own service
and linked to from both BMO and Review Board.

(There's one caveat: if there are multiple reviewers, the first one
gets to choose, in order to limit complexity. Not ideal, but the
problem quickly gets much more difficult if we fork the reviews out to
several tools.)

As with MozReview, the push-to-BMO feature won't support confidential
bugs right away, but we have been working on a design to support
them.  Implementating that will be a priority right after we finish
BMO integration.

We have an aggressive plan for Q1, so stay tuned for updates.

[Engineering Productivity]: https://wiki.mozilla.org/EngineeringProductivity

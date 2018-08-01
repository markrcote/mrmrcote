---
title: "Conduit's Commit Index"
date: 2017-03-21T16:41:29-04:00
categories: ["mozilla", "conduit"]
---
As with MozReview, Conduit is being designed to operate on
changesets. Since the end result of work on a codebase is a changeset,
it makes sense to start the process with one, so all the necessary
metadata (author, message, repository, etc.) are provided from the
beginning. You can always get a plain diff from a changeset, but you
can’t get a changeset from a plain diff.

Similarly, we’re keeping the concept of a logical series of
changesets. This encourages splitting up a unit of work into
incremental changes, which are easier to review and to test than large
patches that do many things at the same time. For more on the benefits
of working with small changesets, a few random articles are
[Ship Small Diffs][], [Micro Commits][], and
[Large Diffs Are Hurting Your Ability To Ship][].

In MozReview, we used the term *commit series* to refer to a set of one
or more changesets that build up to a solution. This term is a bit
confusing, since the series itself can have multiple revisions, so you
end up with a series of revisions of a series of changesets. For
Conduit, we decided to use the term *topic* instead of commit series,
since the commits in a single series are generally related in some
way. We’re using the term *iteration* to refer to each update of a
topic. Hence, a solution ends up being one or more iterations on a
particular topic. Note that the number of changesets can vary from
iteration to iteration in a single topic, if the author decides to
either further split up work or to coalesce changesets that are
tightly related. Also note that naming is hard, and we’re not
completely satisfied with “topic” and “iteration”, so we may change
the terminology if we come up with anything better.

As I noted in my [last post][], we’re working on the push-to-review part
of Conduit, the entrance to what we sometimes call the *commit
pipeline*. However, technically “push-to-review” isn’t accurate, as the
first process after pushing might be sending changesets to Try for
testing, or static analysis to get quick automated feedback on
formatting, syntax, or other problems that don’t require a human to
look at the code. So instead of *review repository*, which we’ve used in
MozReview, we’re calling it a *staging repository* in the Conduit world.

Along with the staging repository is the first service we’re building,
the *commit index*. This service holds the metadata that binds
changesets in the staging repo to iterations of topics. Eventually, it
will also hold information about how changesets moved through the
pipeline: where and when they were landed, if and when they were
backed out, and when they were uplifted into release branches.

Unfortunately a simple “push” command, whether from Mercurial or from
Git, does not provide enough information to update the commit
index. The main problem is that not all of the changesets the author
specifies for pushing may actually be sent. For example, I have three
changesets, A, B, and C, and pushed them up previously. I then update
C to make C′ and push again. Despite all three being in the “draft”
phase (which is how we differentiate work in progress from changes
that have landed in the mainline repository), only C′ will actually be
sent to the staging repo, since A and B already exist there.

Thus, we need a Mercurial or Git client extension, or a separate
command-line tool, to tell the commit index exactly what changesets
are part of the iteration we’re pushing up—in this example, A, B, and
C′. When it receives this information, the commit index creates a new
topic, if necessary, and a new iteration in that topic, and records
the data in a data store. This data will then be used by the review
service, to post review requests and provide information on reviews,
and by the autoland service, to determine which changesets to
transplant.

The biggest open question is how to associate a push with an existing
topic. For example, locally I might be working on two bugs at the same
time, using two different heads, which map to two different
topics. When I make some local changes and push one head up, how does
the commit index know which topic to update? Mercurial bookmarks,
which are roughly equivalent to Git branch names, are a possibility,
but as they are arbitrarily named by the author, collisions are too
great a possibility. We need to be sure that each topic is unique.

Another straightforward solution is to use the bug ID, since the vast
majority of commits to mozilla-central are associated with a bug in
BMO. However, that would restrict Conduit to one topic per bug,
requiring new bugs for all follow-up work or work in parallel by
multiple developers. In MozReview, we partially worked around this by
using an “ircnick” parameter and including that in the commit-series
identifiers, and by allowing arbitrary identifiers via the `--reviewid`
option to “hg push”. However this is unintuitive, and it still
requires each topic to be associated with a single bug, whereas we
would like the flexibility to associate multiple bugs with a single
topic. Although we’re still weighing options, likely an intuitive and
flexible solution will involve some combination of commit-message
annotations and/or inferences, command-line options, and interactive
prompts.

[Ship Small Diffs]: https://blog.skyliner.io/ship-small-diffs-741308bec0d1#.i4yvwn24v
[Micro Commits]: http://lucasr.org/2011/01/29/micro-commits/
[Large Diffs Are Hurting Your Ability To Ship]: https://medium.com/@kurtisnusbaum/large-diffs-are-hurting-your-ability-to-ship-e0b2b41e8acf#.goquvvxts
[last post]: https://mrcote.info/blog/2017/03/14/conduit-field-report/

---
title: "MozReview's Parental issues"
date: 2015-10-22T14:29:00-04:00
categories: ["mozilla", "mozreview"]
---
As mentioned in my [previous post][] on MozReview, one of the biggest
sources of confusion is the way we present the "squashed" diffs, that is,
the diff that show all of the changes in a commit series, the sum
of all the proposed changes.  We also refer to these as "parent"
review requests, since they function as something to hold all the
commits together.  They are stored in MozReview as separate review
requests, similar to the individual commits.

The confusion results from several things:

* The links to the parent are confusing: they are currently labelled
  "Complete diff" and "Review summary".  "Complete diff" doesn't
  clearly indicate that it is the complete diff *of all commits
  together*, and "Review summary" is almost totally meaningless, since
  it *doesn't* include all the reviews left on the commits
  themselves—only reviews left on the overview diff.

* There is nothing in the UI that clearly indicates that you are
  viewing the squashed diff.  The only indication is that none of the rows in
  the commit table are highlighted.  This is particularly confusing
  when there is only one commit, since the squashed diff is
  identical to the commit diff.

* You can leave reviews on the squashed diff, but you can't leave a
  "ship it".  This is because we are enforcing reviewers to
  review individual commits.  However, because there isn't much to
  distinguish parent review requests from commit review requests, it
  can look like the review dialog is just broken.

There are a few simple things we can do to fix these problems: use
better link names, put a big "This is an overview of the commit
series" message, and/or put a warning "You must review individual commits" on
the review dialog. But really, we need to step back and think about the
way we present the squashed diffs, and if they even make sense as
a concept in MozReview.

To reiterate, squashed diffs provide a complete view of a whole commit
series.  The concept of a commit series doesn't exist in core Review
Board (nor does it exist in many other code-review tools), but it's
central to the idea of the repository-centric approach (like in GitHub
pull requests).  We added this concept by storing metadata resulting
from pushes to tie commit series together with a parent, and we added
UI elements like the commits table.

There are three broad ways we can deal with squashed diffs
going forward.  We need to settle on one and make the associated UI
changes to make our model clear to users.

1.  Remove squashed diffs altogether.

    This is the simplest option.  Squashed diffs aren't actually
    technically necessary, and they can distract reviewers from the
    individual commits, which is where they should be spending most of
    their time, since, in most cases, this is how the code will be
    landing in the main repository.  Some other repository-centric
    review tools, like Critic, don't have the concept of an overview
    diff, so there are precedents.  However, it might be a bit heavy
    handed to tell reviewers that they can't view all the commits as a
    single diff (at least, without pulling them down locally).

2.  Continue to allow reviews, of some sort, on squashed diffs.

    This is what we have now: reviewers can leave reviews (at the
    moment, comments only) on squashed diffs.  If we decide we want to
    continue to allow users to leave reviews on squashed diffs, we'll
    need to both figure out a better UI to distinguish them from the
    individual commits and also settle several open questions:

    * Should reviewers be able to grant ship its (i.e. r+s) on
      squashed diffs?  This would imply that the commits probably
      haven't been reviewed individually, which would defeat the
      purpose of a commit-centric system.  That said, reviewer time is
      very important, so we could have a trade off to support more
      work flows.

    * Conversely, should reviewers be able to leave comments on the
      parent diff?  For simplicity, we could allow reviewers to leave
      a "ship it" review on a squashed diff that would apply to all
      commits but force them to leave any comments on diffs on the
      commits themselves.  This would essentially remove the ability
      to review squashed diffs themselves but would leave the
      convenience of saying "this is all good".

    * If we do want to allow review comments on squashed diffs, how
      should they be consolidated with the reviews on individual
      commits?  Right now, reviews (general comments and comments on
      diffs) for the squashed diff and all commits are all on separate
      pages/views.  Giving one view into all activity on a commit
      series would be ideal if we want to support squashed-diff
      reviews. Arguably, this would be valuable even if we didn't have
      reviews on squashed diffs.

    For comparison, GitHub pull requests support this model.  There
    are three tabs in a pull request: "Files changed", which is the
    squashed diff; "Commits", which is a list of commits with links to
    the individual commit diffs; and "Conversation", which shows
    comments on the commits and on the squashed diff (along with other
    events like updates to the commits).  The way they are presented
    is a little confusing (comments on the squashed diff are just
    labelled "&lt;user&gt; commented on the diff", whereas comments on the
    diffs are of the form "&lt;user&gt; commented on &lt;file&gt; in &lt;commit
    hash&gt;"), but it is a useful single view.  However, note that pull
    requests do not have the concept of a "ship it" or "r+", which
    makes the GitHub interface simpler.

    This approach would support multiple reviewer work flows, but it
    is also the most complicated, both in terms of UX and technical
    implementation, and it waters down the philosophy behind
    MozReview.

3.  Provide read-only overview diffs.

    The third approach is to keep squashed diffs but make them read
    only.  They could be used as reference, to get a big picture of
    the whole series, but since they are read only, they would be
    easily distinguishable from commits and would force reviewers to
    look at the individual commits.  This is really just option 1
    above, with a reference view of the whole series.  It would be
    more work than option 1 but less than option 2, and would preserve
    the philosophy.

The MozReview team has been leaning towards option 3.  We have a mock-up
that strips away a lot of the UI that would be useless in this
scenario and makes the intention clear.  It's not the prettiest, but
it wouldn't take too much work to get here:

<img src="http://people.mozilla.org/~mcote/read-only-parent.png" width="800">

However, we'd like to hear user feedback before making any decisions.
Whichever option we go with, we'll come up with a plan to get there
that ideally will have incremental improvements, depending on the
complexity of the full solution, so that we can start to fix things
right away.

[previous post]: https://mrcote.info/blog/2015/09/30/fixing-mozreviews-sore-spots/

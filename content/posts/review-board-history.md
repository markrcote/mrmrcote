---
title: "Review Board history"
date: 2016-01-04T17:19:16-05:00
categories: ["mozilla", "mozreview"]
---
A few weeks ago, mdoglio found an [article from six years ago][] comparing
Review Board and Splinter in the context of GNOME engineering.  This was a
fascinating read because, without having read this article in advance, the
MozReview team ended implementing almost everything the author talked about.

Firstly, I admit the comparison isn't quite fair when you replace
bugzilla.gnome.org with bugzilla.mozilla.org.  GNOME doesn't use attachment
flags, which BMO relies heavily on.  I haven't ever submitted a patch to
GNOME, but I suspect BMO's use of review flags makes the review
process at least a bit simpler.

The first problem with Review Board that he points out is that the
"post-review command-line leaves a lot to be desired when compared to
git-bz".  This was something we did early on in MozReview, all be it
with Mercurial instead: the ability to push patches up to MozReview
with the `hg` command.  Admittedly, we need an extension, mainly
because of interactions with BMO, but we've automated that setup with
`mach mercurial-setup` to reduce the friction.  Pushing commits is the
area of MozReview that has seen the fewest complaints, so I think the
team did a great job there in making it intuitive and easy to use.

Then we get to what the author describes as "a more fundamental
problem": "a review in Review Board is of a single diff".  As he
continues, "More complex enhancements are almost always done as
*patchsets* [emphasis his], with each patch in the set being kept as
standalone as possible. ... Trying to handle this explicitly in the
Review Board user interface would require some substantial changes".
This was also an early feature of MozReview, implemented at the same
time as `hg push` support.  It's a core philosophy baked into
MozReview, the single biggest feature that distinguishes MozReview
from pretty much every other code-review tool out there. It's
interesting to see that people were thinking about this years
before we started down that road.

An interesting aside: he says that "a single diff ... [is] not very
natural to how people work with Git".  The article was written in
2009, as GitHub was just starting to gain popularity.  GitHub users
tend to push fix-up commits to address review points rather than
editing the original commits.  This is at least in part due to
limitations present early on in GitHub: comments would be lost if the
commit was updated.  The MozReview team, in fact, has gotten some push
back from people who like working this way, who want to make a bunch
of follow-up commits and then squash them all down to a single commit
before landing.  People who strongly support splitting work into
several logical commits and updating them in place actually tend to be
Mercurial users now, especially those that use the [evolve extension][],
which can even track bigger changes like commit reordering and insertion.

Back to Review Board.  The author moves onto how they'd have to
integrate Review Board with Bugzilla: "some sort of single-sign-on
across Bugzilla and Review Board", "a bugzilla extension to link to
reviews", and "a Review Board extension to update bugs in Bugzilla".
Those are some of the first features we developed, and then later
improved on.

There are other points he lists that we don't have, like an "automated
process to keep the repository list in Review Board in sync with the
600+ GNOME repositories".  Luckily many people at Mozilla work on just
one repo: mozilla-central.  But it's true that we have to add others manually.

Another is "reduc[ing] the amount of noise for bug reporters", which
you get if you confine all patch-specific discussion to the review
tool.  We don't have this yet; to ease the transition to Review Board,
we currently mirror pretty much everything to Bugzilla.  I would
really like to see us move more and more of code-related discussion to
Review Board, however.  Hopefully as more people transition to using
MozReview full time, we can get there.

Lastly, I have to laugh a bit at "it has a very slick and well developed web
interface for reviewing and commenting on patches".  Clearly we
thought so as well, but there are those that prefer the simplicity of
Splinter, even in 2015, although probably mostly from habit.  Trying
to reconcile these two views is very challenging.


[article from six years ago]: http://blog.fishsoup.net/2009/09/15/review-board-vs-git-bz/
[evolve extension]: https://www.mercurial-scm.org/wiki/EvolveExtension

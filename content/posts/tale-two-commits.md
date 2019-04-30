---
title: "A Tale of Two Commits"
date: 2018-11-30T08:58:41-05:00
categories: ["mozilla"]
---

I've discussed and linked to articles about the advantages of
splitting patches into small pieces to the point that I don't feel the
need to reiterate it here.  This is a common approach at Mozilla,
especially (but not just) in Firefox engineering, something the
Engineering Workflow group is always keeping in mind when planning
changes and improvements to tools and processes.

Many Mozilla engineers have a particular approach to working with
small diffs, something, I've realized over time, that seems to be
pretty uncommon in the industry: the stacking of commits together in a
logical series that solves a particular problem or implements a
specific feature.  These commits are generally authored, reviewed,
updated, and even landed as a set.  They tell a complete story;
indeed, you could view this process as similar to writing a novel: the
book is written, edited, and published as a complete unit.

Contrast this with what appears to be a more common model: commits
constantly trickle into the system.  As changes are made to tell the
story, they are authored, reviewed, and landed as individual parts.
Although work is likely continuing on the next part while the former
is in review, they land as they are ready, and the fix or feature
slowly takes shape in the repo.  This approach is more like a serial
publication, like how *A Tale of Two Cities* and other works by
Dickens were published: one chapter at a time, coming together at the
end as a full story.

That this is a more common approach is seen in the fact that virtually
no code-review tools have first-class support for the stacked-commits,
published-all-at-once method.  We added better support for stacked
commits to Review Board first, and then later to Phabricator.  Both
systems were limited to dependency chaining and in particular lacked
an easy way to submit and update a series of commits at once.
Furthermore, through conversations with Phacility, the makers of
Phabricator, I've learned that they have no intention of implementing
full support for this kind of approach.

Supporting this workflow has a long tail of complexity.  The idea that
a stack of commits tells a complete story means that sometimes
reviewers want to see the entire change, that is, a "squashed diff" of
all the commits at once.  We built this (somewhat clumsily) into
Review Board, but it is still missing in Phabricator.  Another
interesting side effect of editing commits in place within a large
stack is that all child commits need to be rebased.  This can be a
slow operation, as we found out in moz-phab; on top of this, without
some sort of extra intelligence, it results in spurious updates to the
child revisions, particularly in Mercurial where the commit hash
changes when its metadata, including the parent hash, changes.  Other
tools need to be designed with commit stacks in mind as well, such as
Lando, which had stacked landings added as an early feature.

I find it very interesting that the process of working with commit
sets as full stories is rare outside of Mozilla.  Why is this,
exactly?  How did it start?

It's unlikely that it is a function of the size of Firefox's codebase
or its number of contributors.  While Firefox is certainly one of the
larger open-source codebases out there, there are many commercial,
closed-source repos that are larger.  Although it's not easy to get
insights into the tools in some of these companies, I have not heard
that any of them employ the commit-stack approach, and indeed I have
heard otherwise a few times.

Could it be that our historical approaches to landing code, that is,
uploading patch files to a bug as attachments, reviewing the code
through rudimentary tools, pushing manually, and having a nontrivial
chance of being backed out because of a lack of pre-landing tests?
It's tempting to blame old processes, but this would seem to me to
favour the complete opposite of commit stacks: large, standalone
diffs, at least for the tooling parts.  But maybe the prevalence of
backouts is a reason to land commits en masse.

Perhaps it has something to do with Firefox being desktop software,
which is rarer and rarer these days, at least, as a percentage of the
total amount of software being created.  It could be, specifically,
that this is due to the release process of desktop software, which is
much riskier, costlier, and complicated than that of a web
application.  Indeed Chromium is developed with the help of Gerrit,
one of the few review-tools that has some idea of commit stacks.  But
even Gerrit doesn't go to the lengths that Firefox engineers would
like to see in our code-review tools—at least, as far as I can tell,
since I admit that my eyes start to lose focus after I stare at a
Gerrit review for very long.  If this is the case, though, one wonders
if it is as relevant since we moved to shorter release cycles some
time ago.

Or maybe this is generally a really solid practice that has just not
caught on in many other places.  There are lots of really smart and
productive engineers here!  I wonder how a study could be conceived to
verify the gains of this model... something for the data team perhaps.

If you feel you have insights into the philosophy of packaged commit
sets, whether it be reasons behind it, or examples of its use
elsewhere, I'd love to hear them!

---
title: "More lessons from MozReview: Mozilla and Microcommits"
date: 2017-12-04T11:18:34-05:00
categories: ["mozilla", "mozreview"]
---
There is a strong argument in modern software engineering that a
sequence of smaller changes is preferable to a single large
change. This approach facilitates development (easier to debug,
quicker to land), testing (less functionality to verify at once),
reviews (less code to keep in the reviewer’s head), and archaeology
(annotations are easier to follow). Recommended limits are in the
realm of 300-400 changed lines of code per patch (see, for example,
the great article “[How to Do Code Reviews Like a Human (Part Two)][]”).

400 lines can still be a fairly complex change. *Microcommits* is the
small-patch approach taken to its logical conclusion. The idea is to
make changes as small as possible but no smaller, resulting in a
series of atomic commits that incrementally implement a fix or new
feature. It’s not uncommon for such a series to contain ten or more
commits, many changing only 20 or 30 lines. It requires some
[discipline][] to keep commits small and cohesive, but it is a skill that
improves over time and, in fact, changes how you think about building
software.

Former Mozillian Lucas Rocha has a great [summary][] of some of the
benefits. Various other Mozillians have espoused their personal
beliefs that Firefox engineering would do well to more widely adopt
the microcommits approach. I don’t recall ever seeing an organized
push towards this philosophy, however; indeed, for better or for worse
Mozilla tends to shy away from this type of pronouncement. This left
me with a question: have many individual engineers started working with
microcommits? If we do not have a *de juror* decision to work this way,
do have a *de facto* decision?

We [designed MozReview][] to be repository-based to encourage the
microcommit philosophy. Pushing up a series of commits automatically
creates one review request per commit, and they are all tied together
(albeit through the “parent review request” hack which has
understandably caused some amount of confusion). Updating a series,
including adding and removing commits, just works. Although we never
got around to implementing support for confidential patches (a
difficult problem given that VCSs aren’t designed to have a mix of
permissions in the same repo), we were pretty proud of the fact that
MozReview was unique in its first-class support for publishing and
reviewing microcommit series.

While MozReview was never designated *the* Firefox review tool,
through organic growth it is now used to review (and generally land)
around 63% of total commits to mozilla-central, looking at stats for
bugs in the Core, Firefox, and Toolkit products:

![Code change attachments by type](/images/code-change-attach-by-type.png)

To be honest, I was a little surprised at the numbers. Not only had
MozReview grown in popularity over the last year, but much of its
growth occurred right around the time its pending retirement was
announced. In fact, it continued to grow slightly over the rest of the
year.

However, we figured that, owing to MozReview’s support for
microcommits, this wasn’t quite a fair comparison. Bugzilla’s
attachment system discourages multiple patches per bug, even with
command-line tools like bzexport. So we figured that, generally, a fix
submitted to MozReview would have more parts than a corresponding fix
submitted as a traditional BMO patch. Thus the
bug-to-MozReview-request ratio would be lower than the bug-to-patch
ratio. We ran a query on the number of MozReview requests per bug in
about the last seven months. These results yielded further surprises:

![MozReview requests per bug](/images/mozreview-count-per-bug.png)

About 75% of MozReview commit “series” contain only a single
commit. 12% contain only two commits, 5% contain three, and 2.7%
contain four. Series with five or more commits make up only 5.3%.

Still, it seems MozReview has perhaps encouraged the splitting up of
work per bug to some degree, given that 25% of series had more than
one commit. We decided to compare this to traditional patches attached
to bugs, which are both more annoying to create and to apply:

![Patch count per bug](/images/patch-count-per-bug.png)

Well then. Over approximately the same time period, of bugs with
old-style attachments, 76% had a single patch. For bugs with two,
three, and four patches, the proportions were 13%, 7%, and 1.5%,
respectively. This is extremely close to the MozReview case. The mean
is almost equal in both cases, in fact, slightly higher in the
old-style-attachment case: 1.65 versus 1.61. The median in both cases
is 1.

Okay, maybe the growing popularity of MozReview in 2017 influenced the
way people now use BMO. Perhaps a good number of authors use both
systems, or the reviewers preferring MozReview are being vocal about
wanting at least two or three patches over a single one when reviewing
in BMO. So we looked back to the situation with BMO patches in early
2016:

![Patch count per bug 2016Q1](/images/patch-count-per-bug-2016Q1.png)

Huh. One-, two-, three-, and four-patch bugs accounted for 74%, 14%,
5%, and 2.6%, respectively.

For one more piece of evidence, this scatter plot shows that, on
average, we’ve been using both BMO and MozReview in about the same
way, in terms of discrete code changes per bug, over the last two
years:

![Patch and MozReview request counts per bug](/images/patch-and-mozreview-request-counts-per-bug.png)

There are a few other angles we could conceivably consider, but the
evidence strongly suggests that developers are (1) creating, in most
cases, “series” of only one or two commits in MozReview and (2)
working in approximately the same way in both BMO and MozReview, in
terms of splitting up work.

I strongly believe we would benefit a great deal from making more of
engineering’s assumptions and expectations clearer; this is a
foundation of [driving effective decisions][]. We don’t have to be
right all the time, but we do have to be conscious, and we have to own
up to mistakes. The above data leads me to conclude that the
microcommit philosophy has not been widely adopted at Mozilla. We
don’t, as a whole, care about using series of carefully structured and
small commits to solve a problem. *This is not an opinion on how we*
***should*** *work, but a conclusion on how we* ***do*** *work,
informed by data*. This is, in effect, a decision that has already
been made, whether or not we realized it.

Although I am interested in this kind of thing from an academic
perspective, it also has a serious impact to my direct
responsibilities as an engineering manager. Recognizing such decisions
will allow us to better prioritize our improvements to tooling and
automation at Mozilla, even if it has to first precipitate a serious
discussion and perhaps a difficult, conscious decision.

I will have more thoughts on why we have neither organically nor
structurally adopted the microcommits approach in my next blog
post. Spoiler: it may have to do with prevailing trends in open-source
development, likely influenced by GitHub.

[How to Do Code Reviews Like a Human (Part Two)]: https://mtlynch.io/human-code-reviews-2/
[discipline]: https://dev.to/rpalo/plan-your-commits
[summary]: http://lucasr.org/2011/01/29/micro-commits/
[designed MozReview]: https://mozilla-version-control-tools.readthedocs.io/en/latest/mozreview/commits.html#prefer-more-smaller-commits-over-large-monolithic-commits
[driving effective decisions]: https://mrcote.info/blog/2017/09/07/decisions/

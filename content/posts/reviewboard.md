---
title: "ReviewBoard"
date: 2013-11-26T12:37:00-04:00
categories: ["mozilla", "bmo"]
---
There's been a lot of interest in improving Mozilla's code-review
process lately, so in that vein the [BMO][] team has set up a
[ReviewBoard][] instance at https://reviewboard.allizom.org for
testing and evaluation.

ReviewBoard is a lot more useful than Splinter, so I suggest you try
it out.  One of the features I think will be most adored is proper
interdiff support, made possible by the fact that ReviewBoard knows
about the repo you're working in.  Tightly related is the ability to
extend the context of the patch from the repo.  Check out the
[ReviewBoard][] site for more.

Review apps, like most tools, are fairly contentious, so we wanted to
give Mozillians a chance to try it out before we commit to it.  Other
options, like [Phabricator][], have been [suggested][]; we happened to
have been working on ReviewBoard. I'd like to hear from the greater
public before settling on one for at least a few years.

For this experimentation phase, we've only done minimal integration
with Bugzilla, namely, having ReviewBoard use Bugzilla's accounts.
You log into ReviewBoard with your Bugzilla account, and ReviewBoard's
username autosuggest is linked to Bugzilla (similarly, reviewboard-dev
uses bugzilla-dev's user database).  (Note that this version of
ReviewBoard doesn't support Persona, but it should be there soon.)
There's a lot more we could do; some examples are in [bug 515210][].
Again I'd like to hear feedback in order to prioritize our work.

I suggest using ReviewBoard much like we use GitHub pull requests.
Start a review, then paste the URL as an attachment on a Bugzilla
bug.  [Bug 922226] is on file to get redirects working for ReviewBoard
reviews the way [they do for pull requests].

For now, please don't use ReviewBoard for any non-public
(e.g. security-related) or really critical reviews.  While the
security team has gone over ReviewBoard, we're still considering this
an evaluation phase.  We'll also have to put some work into ensuring
that only the right people can see non-public reviews; Bugzilla's
security system is rather fine-grained and complicated, so this will
take some thought and possibly some modifications to ReviewBoard
itself (don't worry, we have several ReviewBoard developers in house!).

Finally, to get your repo added--having a linked repo is where you
really see the value of ReviewBoard--either [file a bug][] or drop by
\#bmo on IRC.

Please direct all feedback to [mozilla.tools.bmo][].  To reinforce
that, I've disabled comments on this post.


[BMO]: https://wiki.mozilla.org/BMO
[ReviewBoard]: http://www.reviewboard.org
[Phabricator]: http://phabricator.org/
[suggested]: http://gregoryszorc.com/blog/2013/10/14/phabricator-is-awesome/
[bug 515210]: https://bugzilla.mozilla.org/show_bug.cgi?id=515210
[Bug 922226]: https://bugzilla.mozilla.org/show_bug.cgi?id=922226
[they do for pull requests]: http://globau.wordpress.com/2013/10/21/github-pull-requests-and-bugzilla/
[file a bug]:https://bugzilla.mozilla.org/enter_bug.cgi?product=bugzilla.mozilla.org&component=Administration
[mozilla.tools.bmo]: https://lists.mozilla.org/listinfo/tools-bmo

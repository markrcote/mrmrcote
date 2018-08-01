---
title: "A Vision for Engineering Workflow at Mozilla (part one)"
date: 2018-05-31T09:18:29-04:00
categories: ["mozilla"]
---

The OED's second [definition][] of "vision" is "the ability to think
about or plan the future with imagination or wisdom."  Thus I felt
more than a little trepidation when I was tasked with creating a
vision for my team.  What should this look like?  How do I scope it?
What should it cover?  The Internet was of surprisingly little help;
it seems that either no one thinks about tooling and engineering
processes at this level, or (perhaps more likely) they keep it a
secret when they do.  The best article I found was from Microsoft
Research in which they studied how tools are adopted at Microsoft, and
their conclusion was essentially that they had no overarching
strategy.

Around six months later, I presented a Vision for Engineering Workflow
at our fortnightly managers' meeting.  But first, some context: a bit
about Mozilla's Engineering Workflow team, and about the challenges we
face.

Engineering Workflow
====================

The Engineering Workflow team was created in the Great Reorg of 2017,
when, amongst other large changes, its predecessor, the Automation &
Tools team (aka the A-Team) was split into two, with the part focussed
more on test automation joining the newly formed Product Integrity
org.  The other half remained in the Engineering Operations org, along
with a related team, managed by [coop][], that worked on the build and
version-control systems.  In February, these two teams were
consolidated into a single team, with [kmoir][] joining the team as a
new manager while coop headed off to [manage the Taskcluster team][].

We named this new team "Engineering Workflow" to reflect that it is
focussed on the first stages of the Firefox engineering pipeline, that
is, tools and processes that most developers use on a day-to-day
basis.  Our mission is as follows:

> The engineering workflow team exists to improve the quality,
> clarity, and efficiency of Firefox development through the
> integration and development of tools and automation.

More specifically, the major pieces of the engineering pipeline that
we work on are

* Tracking issues
* Reviewing code
* Landing code
* Building Firefox

Just as importantly, there are many related systems that we *don't*
own.  These include

* Tests and test frameworks.  As mentioned above, these are the
  responsibility of the Product Integrity org.
* Release and update infrastructure.  This is the domain of release
  engineering and release management.
* Metrics related to product use.  Although we are starting to collect
  our own metrics, data related to Firefox itself is collected and
  analyzed by the data and product teams.
* Firefox Developer Experience (aka devtools).  I mention this only
  because they have (or at least had) a similar name.  This is the
  team that works on the developer tools that are shipped as part of
  Firefox.
* Low-level tools.  These tools are very product focussed, requiring
  intimate knowledge of the Firefox codebase and C++ development.
  This team is managed by [Anthony Jones][] and is part of the Runtime
  Engineering group.
* Products not built from mozilla-central.  To allow us to focus (I
  seem to really love that word), we prioritize work to help
  developers working within the [mozilla-central][] codebase.  Many of
  our tools are also used by other teams (including ourselves!) but
  support requests from them are considered lower priority.

Of course, we can and do work with many of these other teams on joint
ventures.  Over time I would like to better coordinate our respective
road maps to deliver even more impact to engineering at Mozilla.

Challenges
==========

Mozilla is a unique place.  Not only are we a nonprofit that works in
the open, but we develop a massive application with contributors, both
paid and volunteer, located all around the world.  This means we also
face unique challenges when it comes to figuring out what tools and
automation to integrate, build, and/or improve to maximize impact.
I'll touch on a few here.

Diverse workflows and strong preferences
----------------------------------------

Tales of "religious wars" within software develop stretch back
decades, so it is no surprise that many Mozillians have strong
opinions about the way they prefer to work.  What is less common is
that Mozilla has generally shied away from defining official (or even
officially supported) tools and processes.  I won't get into the
merits of this approach, but it does impact tooling teams, who have to
either support multiple workflows in their tools or unilaterally
decide to prioritize some over others.

A few examples:

* git versus modern hg versus mq.  Not only are developers split
  across two VCSes, but even within Mercurial users there are
  differences (though thankfully mq usage seems to be much lower than
  a few years ago).
* microcommits and commit series.  Some developers tend to create a
  single patch per bug.  A good number create a few patches per bug,
  sometimes as followups but often as one chunk of work.  And there
  are a small number who, at least at times, create long series of
  commits, sometimes on the order of 20 to 40.  Furthermore, despite
  the growing popularity of the commit-series philosophy, including at
  Mozilla, proper support in review tools remains rare.
* importance of features in code-review and issue-tracking apps.
  Unsurprisingly, as developers spend much of their days working with
  bugs and code changes, they tend to get opinionated as to how the
  tools could be made better.  It's tricky to know which features to
  prioritize when both improving and migrating tools.

I am happy to report, however, that there is more and more support for
consolidating workflows at Mozilla.

Engineering scale
-----------------

Firefox is a huge application.  A full Mercurial clone currently takes
up 3.6 GB of disk space.  Without Mercurial metadata the codebase,
including build, test, and third-party libs and apps, contains over
245 000 files in more than 17 000 directories totalling almost *20
million* lines of code.  [There aren't too many projects][] the size
of Firefox, open source or otherwise.

Unsurprisingly, since Firefox remains very active, there are a lot of
changes going into the codebase: about 180 per day in April 2018.
Contrast this with about 25-30 per day [going into the Linux kernel][].
This also doesn't count pushes to the [try server][] for testing works
in progress.  April saw [210 compute years][] in our CI system.

Finally, we have complicated security requirements.  Mozilla is open
by design, with many tools and processes exposed to the public (and
the public Internet!).  Our approach to [governance][] does not
restrict positions of authority and responsibility to employees.
These complexities and subleties can be seen in BMO's permission
system, which is much more fine-grained than what is built into most
issue-tracking and code-review tools.

All these factors create difficult problems when integrating
third-party tools into our systems.  In addition, although we do this
less than we used to, our scale means that there are not always
existing solutions out there that meet our needs, requiring us to
write custom applications that need to be highly scalable and secure.

Legacy
------

Related to the scale of Firefox development is its long legacy.  The
Mozilla Foundation is 20 years old, with the Netscape code dating back
even further.  Although Mozilla has grown dramatically as an entity,
many workflows persist over the years, including the reviewing of
patches in Bugzilla and the use of [Mercurial queues][].
Understandably, when developers have used a certain workflow for many
years, they are often skeptical of change.  Yet newer contributors are
more familiar with modern workflows, so modern tooling can help
attract and retain both employees and volunteers, in addition to the
various other advantages in terms of ergonomics, usability, and
efficiency.  Contending with these two perspectives can be difficult.

In addition to legacy workflows, we also have a number of legacy
systems.  Many of these systems continue to serve us well, and we are
constantly making improvements to them.  However, large-scale changes
can be difficult, both because of the age of these systems and
codebases, but also because over time they have been integrated with
many other applications and used in ways we aren't aware of and
sometimes don't expect.  This makes planning challenging and requires
a lot of communication.

Decision-making and responsibility
----------------------------------

I'm happy to say that this set of challenges has seen the most
improvement of the ones I've highlighted.  I'll mention them
regardless as we can always be improving, and an understanding of our
history helps.

Decision-making at Mozilla has been challenging for a number of
reasons, mainly due to its history and rapid growth.  In particular,
there was a common view that we aimed for consensus on all major
decisions, which, while well-intentioned, did not scale, and in fact
was contradicted by both our management and module systems.  This has
led both to stalled decisions and sudden decisions that avoided
discussions altogether.  I've previously [written][] about my
perspectives and experiences in making decisions at Mozilla.
Thankfully, as I also noted, this culture is changing, and making
effective, reasoned decisions is getting easier.

Within my own team, or at least its previous incarnation as the
A-Team, we experienced our own difficulties making decisions and
prioritizing work.  There were no clear lines of authority and
responsibility when it came to tooling, which also contributed to our
team becoming too service oriented.  Again, this is changing for the
better with existence of both Engineering Operations and Product
Integrity, whose directors are peers of those of the product-focussed
departments.

Thus ends my preamble on the context of developing a Vision for
Engineering Workflow.  In my next post, I'll delve into the Vision itself.

[definition]: https://en.oxforddictionaries.com/definition/vision
[coop]: http://coopcoopbware.tumblr.com/
[kmoir]: https://kimmoir.blog
[manage the Taskcluster team]: http://coopcoopbware.tumblr.com/post/173126143130/new-to-me-the-taskcluster-team
[Anthony Jones]: https://www.blogger.com/profile/13812745278081914271
[mozilla-central]: https://hg.mozilla.org/mozilla-central
[There aren't too many projects]: https://medium.freecodecamp.org/the-biggest-codebases-in-history-a128bb3eea73
[going into the Linux kernel]: https://github.com/torvalds/linux/pulse/monthly
[try server]: https://wiki.mozilla.org/ReleaseEngineering/TryServer
[210 compute years]: https://twitter.com/ccooper/status/1001826908206755842
[governance]: https://www.mozilla.org/en-US/about/governance/
[Mercurial queues]: https://developer.mozilla.org/en-US/docs/Mozilla/Mercurial/Queues
[written]: https://mrcote.info/blog/2017/09/07/decisions/

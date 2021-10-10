---
title: "A Vision for Engineering Workflow at Mozilla (Part Three)"
date: 2018-07-10T10:49:08-04:00
categories: ["mozilla"]
---
This is the last post in a three-part series on A Vision for
Engineering Workflow at Mozilla.  The [first post][] in this series
provided some background, while the [second][] introduced the first
four points of our nine-point vision.

The Engineering Workflow Vision (continued)
===========================================

5\. Reviews are straightforward and streamlined
----------------------------------------------

The Engineering Workflow team has spent a lot of time over the last
few years on review tools, starting with Splinter, moving into
MozReview, and now onto Phabricator.  In particular, MozReview was a
grand experiment; its time may be over, but we learned a lot from the
project and are incorporating these lessons not just into our new
tools but also into how we work.

There are a lot of aspects to the code-review process.  First and
foremost is, of course, the tool that is used to actually leave
reviews.  One important meta-aspect of review-tool choice is that
there *should only be one*.  Mozilla has suffered from the problems
caused by multiple review tools for quite a long time.  Even before
MozReview, users had the choice of raw diffs versus Splinter.
Admittedly, the difference there is fairly minimal, but if you look at
reviews conducted with Splinter, you will see the effect of having two
systems: *initial* reviews are done in Splinter, but follow ups are
almost always done as comments left directly in the bug.  The Splinter
UI rarely shows any sort of conversation.  We didn't even use this
simple tool entirely effectively.

Preferences for features and look and feel in review tools vary
widely.  One of the sole characteristics that is uncontroversial is
that it should be fast—but of course even this is a trade off, as
nothing is faster than commenting directly on a diff and pasting it as
a comment into Bugzilla.  However, at a minimum the chosen tool should
not *feel* slow and cumbersome, regardless of features.

Other aspects that are more difficult but nice to have include

* Differentiating between intentional changes made by the patch author
  versus those from the patch being rebased
* Clear and effective interdiff support
* Good VCS integration

For the record, while not perfect, we believe Phabricator, our
[chosen review tool][] for the foreseeable future, fares pretty well
against all of these requirements, while also being relatively
intuitive and visually pleasing.

There are other parts of code review that can be automated to ease the
whole process.  Given that they are fairly specific to the way Mozilla
works, they will likely need to be custom solutions, but the work and
maintenance involved should easily be paid off in terms of efficiency
gains.  These include

* Automated reviews to catch all errors that don't require human
  judgement, e.g., linting.  Even better would be the tool fixing such
  errors automatically, which would eliminate an extra review cycle.
  This feedback should ideally be available both locally and after
  review submission.
* Reviewers are intelligently suggested.  At the minimum, our
  [module system][] should be reflected in the tool, but we can do
  better by calculating metrics based on file history, reviewer load
  and velocity, and other such markers.
* Similarly, code owners should be clearly identified and enforced; it
  should be made clear if the appropriate reviewers have not signed
  off on a change, and landing should be prevented.

This last point segues into the next item in the vision.

6\. Code is landed automatically
-------------------------------

Mozilla has had an autoland feature as part of MozReview for about 2.5
years now, and we recently launched [Lando][] as our new
automatic-landing tool integrated with Phabricator.  Lando has incorporated
some of the lessons we learned from MozReview (not the least of which
is "don't build your custom tools directly into your third-party
tools"), but there is much we can do past our simple click-to-land
system.

One feature that will unlock a lot of improvements is purely automatic
landings, that is, landings that are initiated automatically after the
necessary reviews are granted.  This relies on the system
understanding which reviews are necessary (see above), but beyond that
it needs just a simple checkbox to signal the author's intent to land
(so we avoid accidentally landing patches that are works in progress).
Further, as opposed to Try runs for testing, developers don't tend to
care too much about the time to land a completed patch as long as a
whole series lands together, so this feature could be used to schedule
landings over time to better distribute load on the CI systems.

Automatic landings also provide opportunities to reduce manual
involvement in other processes, including backouts, uplifts, and
merges.  Using a single tool also provides a central place for
record-keeping, to both generate metrics and follow how patches move
through the trains.  More on this in future sections.

7\. Bug handling is easy, fast, and friendly
-------------------------------------------

Particularly at Mozilla, bug tracking is a huge topic, greater than
code review.  For better or worse, Bugzilla has been a major part of
the central nervous system of Mozilla engineering since its earliest
days; indeed, Bugzilla turns 20 in just a couple months!  Discussing
Bugzilla's past, present, and future roles at Mozilla would take many
blog posts, if not a book, so I'll be a bit broad in my comments
here.

First, and probably most obviously, Mozilla's bug tracker should
prioritize usability and user experience (yes they're [different][]).
Mozilla engages not just full-time engineer employees but also a very
large community with diverse backgrounds and skill sets.  Allowing an
engineer to be productive while encouraging users without technical
backgrounds to submit bug reports is quite a challenge, and one that
most high-tech organizations never have to face.

Another topic that has come up in the past is search functionality.
Developers frequently need to find bugs they've seen previously, or
want to find possible duplicates of recently filed bugs.  The ideal
search feature would be fast, of course, but also accurate and
relevant.  I think about these two aspects are slightly differently:
accuracy pertains to finding a specific bug, whereas relevancy is
important when searching for a class of bugs matching some given
attributes.

Over the past couple years we have been trying to move certain use
cases out of Bugzilla, so that we can focus specifically on
engineering.  This is part of a grander effort to consolidate
workflows, which has a host of benefits ranging from simpler, more
intuitive interfaces to reduced maintenance burden.  However this
means we need to understand specific use cases within engineering and
implement features to support them, in addition to the more general
concerns above.  A recent example is the refinement of triage
processes, which is helped along by specific improvements to Bugzilla.

8\. Metrics are comprehensive, discoverable, and understandable
--------------------------------------------------------------

The value of data about one's products and processes is not something
that needs much justification today.  Mozilla has already invested
heavily in a data-driven approach to developing Firefox and other
applications.  The Engineering Workflow team is starting to do the
same, thanks to infrastructure built for Firefox telemetry.

The list of data we could benefit from collecting is endless, but a
few examples include
* backout rates and causes
* build times
* test-run times
* patch-review times
* tool adoption

We're already gathering and visualizing some of these stats:

![Review tool stats](/images/review-tools.png)

Naturally such data is even more valuable if shared so other teams can
analyze it for their benefit.

9\. Information on "code flow" is clear and discoverable
-------------------------------------------------------

This item builds on the former.  It is the most nebulous, but to me it
is one of the most interesting.

Code changes (patches, commits, changesets, whatever you want to call
them) have a life cycle:

1. A developer writes one or more patches to solve a problem.
   Sometimes the patches are in response to a bug report; sometimes a
   bug report is filed just for tracking.

2. The patches are often sent to Try for testing, sometimes multiple
   times.

3. The patches are reviewed by one or more developers, sometimes
   through multiple cycles.

4. The patches are landed, usually on an integration branch, then
   merged to mozilla-central.

5. Occasionally, the patches are backed out, in which case flow
   returns to step 1.

6. The patches are periodically merged to the next [channel][] branch,
   or occasionally uplifted directly to one or more branches.

7. The patches are included in a specific channel build.

8. Repeat 6. and 7. until the patch ends up in the mozilla-release
   branch and is included in a Release build.

There's currently no way to easily follow a code change through these
stages, and thus no metrics on how flow is affected by the various
aspects of a change (size, area of code, author, reviewer(s), etc.).
Further, tracking this information could provide clear indicators of
flow problems, such as commits that are ready to land but have merge
conflicts, or commits that have been waiting on review for an extended
period.  Collecting and visualizing this information could help
improve various engineering processes, as well as just the simple
thrill of literally watching your change progress to release.

This is a grand idea that needs a lot more thought, but many of the
previous items feed naturally into it.

Conclusion
==========

This vision is just a starting point.  We're building a [road map][]
for short-to-medium-term map, while we think about a larger
2-to-3-year plan.  Figuring out how to prioritize by a combination of
impact, feasibility, risk, and effort is no small feat, and something
that we'll likely have to course-correct over time.  Overall, the
creation of this vision has been inspiring for my team, as we can now
envision a better world for Mozilla engineering and understand our
part in it.  I hope the window this provides into the work of the
Engineering Workflow team is valuable to other teams both within and
outside of Mozilla.

[first post]: /blog/2018/05/31/a-vision-for-engineering-workflow-at-mozilla-part-one/
[second]: /blog/2018/07/05/a-vision-for-engineering-workflow-at-mozilla-part-two/
[chosen review tool]: /blog/2018/06/06/phabricator-and-lando-launched/
[module system]: https://www.mozilla.org/en-US/about/governance/policies/module-ownership/
[Lando]: https://lando.services.mozilla.com
[different]: https://usabilitygeek.com/the-difference-between-usability-and-user-experience/
[channel]: https://wiki.mozilla.org/Release_Management/Release_Process
[road map]: https://wiki.mozilla.org/Engineering_Workflow/Road_Map

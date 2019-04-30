---
title: "Deconstruction of a Failure"
date: 2019-04-30T08:38:57-04:00
categories: ["mozilla"]
---
Something I regularly tell my daughter, who can tend towards perfectionism, is
that we all fail.  Over the last few years, I've seen more and more talks and
articles about embracing failure.  The key is, of course, to _learn_ from the
failure.

I've written
[a bit before](/blog/2017/12/04/more-lessons-from-mozreview-mozilla-and-microcommits/)
about what I learned from leading the MozReview project, Mozilla's experiment
with a new approach to code review that lasted from about 2014 to 2018.  I'm
still teasing lessons out of the experience.  Here are a few that I've been
thinking a lot about lately.

I first want to say that I don't think MozReview was a total failure.  There
were many successes, despite the fact that we decommissioned it in favour of
another system.  Indeed, as I note below, we had quite a big userbase near the
end.  I am also sure that perspectives on MozReview vary quite a bit among the
team that worked on it.  These are just the particular failures that I felt most
responsible for and, thus, were the most instructive for me.

That these failures occurred early in my management career was, overall, a good
thing.  I can say that I learned quite a lot from the project, and it made me a
better manager.  I apply the lessons I've learned to all my team's projects now,
and I try to pass on this knowledge to others, not so they can avoid failure,
but so that they can perhaps recognize it earlier than I did.

Failure to recognize failure
----------------------------

MozReview started out as essentially a skunkworks project with only a few
people: an engineering manager to oversee the project, a couple coders (one full
time, one contract), and a senior-staff-level (or thereabouts) engineer who
acted as a sort of customer/consultant.  Over the next few months, a couple more
engineers helped out in various ways, and I was pulled in to add Bugzilla
support.  Later, when the other engineering manager left, I took over the
project.

I say “took over”, but that’s not entirely accurate.  The project was in some
disarray at that time.  The customer/consulting engineer was no longer very
involved in the project, the contractor’s term had ended, and the other dev was
being pulled in different directions.  I don't think I even recognized right
away that I was in charge, and, when I did, the only reason I kept the
responsibility for the project was that no one else offered.

The funny thing about experience slowly gained over time is that it makes
certain situations look completely obvious in retrospect.  It's hard to think
back to that time, when I was relatively new to management and Mozilla itself
was grappling with a lot of change.  From my current vantage point, I have to
remind myself that my lack of experience, mixed with the chaotic environment at
that time, prevented me from seeing what a mess that project was in, and that
some serious change was needed.

The two biggest red flags were that the project had no dedicated resources and
no stakeholders.  The first problem was sufficiently obvious that I was able to
fix it with some time, first by borrowing the original dev from his regular day
job for a fixed period, and later by getting him transferred to our org (where
his real interests lay).  The second problem was, unfortunately, not very
obvious to me back then.

MozReview proposed a big, maybe even radical, shift in the way code review was
to be conducted at Mozilla.  This kind of project _needs_ buy-in from a variety
of people, particularly leadership, both technical and managerial.  Since I
hadn't started the project, I didn't realize for quite a while how little anyone
knew about it, or how many people actually saw a need for change.  I should have
paused the project and done some serious customer research and evangelism (since
the team honestly believed the new ways of working that MozReview represented
would have a positive impact on productivity, at least over time).  Instead, I
let the project stumble on, almost of its own will, into some sort of Kafkaesque
scenario in which we seemed to be working on the project because we had been
working on the project.

MozReview existed for about four years.  During that time, we had two main
code-review systems (or three if you count GitHub).  This is too long to suffer
through that kind of split, given that, unlike the Git vs. Mercurial situation,
many people had to use both systems, to review code at least.  And although it
gave us a lot of opportunity to continually improve the system, it caused an
undue amount of extra cognitive load given that we never felt
justified—correctly or incorrectly, I’m not sure—to switch entirely to
MozReview.

MozReview needed to be treated as a real experiment, something that Mozilla, and
perhaps the industry at large, did not do as much of five years ago.  The core
hypothesis of the problem that MozReview was designed to solve needed to be
clearly articulated early on, such that a prototype, or at least a tool with a
much more focussed scope, could have been built to quickly confirm its value.
And it turned out that we didn’t even have a crisp hypothesis in the first
place.  More on that in a minute.

Keeping MozReview going in this zombie-like fashion was my single biggest
failure both in the project and in my management career so far.  As I mentioned,
I believe there were some circumstances well outside of my control that
contributed to the state of the project and my reticence to reach out for help
to get it back on track.  However, a combination of inexperience, naïveté, and
lack of confidence on my part was likely the biggest reason that we ended up
spending far too much time on MozReview before it was eventually decommissioned.

Unarticulated goals are worthless
---------------------------------

MozReview was a chance to use a more powerful code-review tool.  Mozilla had
been using
[Splinter](https://blog.fishsoup.net/2009/09/23/splinter-patch-review/) for
several years, which was a step up from raw diffs, but a small one. Furthermore,
in part because of the way Splinter was integrated with Bugzilla, it was often
only used for the initial review, with follow-up happening just within bug
comments.  More powerful code-review tools had been in existence for some time,
so, since we were building new automation around code reviews, this was an
opportunity to try one out.

Changing the workflow around code reviews at the same time as changing the
code-review tool itself, however, was too much at once.  Despite some of the
similarities to GitHub’s flow, the [commit-series concepts](/blog/2018/11/30/a-tale-of-two-commits/)
were new to many people, as were the related concepts in Mercurial.  The shift
was made all the harder by having to understand a new interface at the same
time, which was pretty rough in places from the way we initially bolted the new
commit-series functionality onto Review Board.

In other words, we appeared to have two goals at the same time—switching to a
modern code-review tool, and adopting a commit-series-centric workflow.  This
had many ramifications: too much to learn at once, a confusion as to what parts
of the new system were responsible for what, and too much to work on at the
same time for the MozReview developers.  Possibly worse than anything, we didn’t
even clearly articulate the objectives of the new system to _ourselves_, which
was probably the main reason we had one too many goals.

The lesson here is to pick one main goal when you are making a big change.  If
you feel that you have to have more than one goal, at least make them very
closely related.  Or to put it another, simpler way, don’t change too much at
once.

But how we were actually doing?
-------------------------------

Although we kept MozReview going too long without proper analysis of the
situation, we _did_ have some loyal users.  I'm not sure what combination of
qualities led this group to persist through or work around some of the confusing
aspects of MozReview in the early days; perhaps they were
[early adopters](https://en.wikipedia.org/wiki/Early_adopter), perhaps they
appreciated some of the
[lesser-known but very powerful](https://www.mercurial-scm.org/wiki/EvolveExtension)
aspects of Mercurial, or perhaps they just couldn't stand the way code reviews
had been traditionally done at Mozilla.  Whatever it was, we knew they existed,
but it was hard for us to hear them.

Some of us knew that the people who disliked MozReview the most (for a variety
of reasons, which varied from person to person) likely didn’t represent the
majority… but for some reason, we didn’t take the time to actually measure
adoption.  Somewhat ironically, we only finally put into place our
[commit-telemetry](https://github.com/mozilla-conduit/commit-telemetry-service)
service, which provides various insights into code landing in mozilla-central,
after we announced that MozReview would be replaced by Phabricator.  Mozilla
had embraced data in the intervening years, and at that point it seemed the
logical choice to measure Phabricator adoption.

It surprised many (but not all) of my team to find out that, at the point that
we announced the move to Phabricator, over 60% of commits going into
[mozilla-central](https://hg.mozilla.org/mozilla-central) were being reviewed
in MozReview.  We didn’t go back into history to determine the trend, as there
wasn’t much point at that time, but I wonder if and how this data would have
changed the conversation around MozReview during the previous couple years.

And then there was the implementation...
----------------------------------------

The team working on MozReview over the years was made up of some very smart
people.  What we didn't have, however, was much experience taking a third-party
application and bending it to our needs.  We started off modifying Review Board
to incorporate our new commit-series approach via their extension system.  This
seemed like a pretty natural place to start; after all, that’s what extensions
are for, right?

Unfortunately we reached the limit of what extensions could do fairly quickly.
How we wanted to use Review Board required some fairly deep changes, both
technically and conceptually.  After a few attempts to hack the UI via front-end
extensions, we finally gave up and… forked the codebase.

The initial result was very positive.  We were able to make large changes to the
user interface without contorting ourselves around the limitations of the
extension system.  Unfortunately, after launching the new UI it became quickly
apparent that upgrading Review Board itself would be a large undertaking.  Even
small version bumps required some hours to modify and test our changes.  We kept
kicking that can down the road, backporting security patches and basically
ignoring everything else happening upstream.  Upgrading a major version, from 2
to 3, was almost out of the question, despite that we knew that one day version
2 would be unsupported.  As it happened, a few months after we forked we made
the decision to move away from MozReview.  But for the year and a bit that it
remained active, while we were building out and validating Phabricator, we lived
in perpetual fear that there would be a large security release that might take
MozReview down for days while we applied it.

It seems pretty obvious in hindsight that integrations should be limited to
using APIs, maybe some light extensions, and never forking.  APIs are the most
stable way to integrate new functionality into a system, since they are crafted
by the developers to be the officially supported avenues into the internals.
Extensions are tempting, but, precisely because they generally allow fairly
deep integrations, they are dangerous from a maintenance perspective for
anything but the simplest new functionality.  And forking means you’re now
essentially committed to maintaining the whole codebase of the original app
yourselves.

What is less obvious is exactly how we would have accomplished our goals
following the above rule.  There’s no easy answer here, but I’ve found some
ideas.  The O’Reilly book _Building Microservices_, by Sam Newman, has an
interesting chapter on integrating with third-party software.  Despite the title
of the book, Newman’s approaches to dealing with commercial off-the-shelf
software aren’t particularly, or at least aren’t necessarily, microservice-y.

He forgoes the use of built-in customization options and extension systems and
instead advocates for building services—front ends and façades—around the
system that are loosely coupled via its APIs.  These provide interfaces, both
UIs and new APIs, that are better suited to the needs of the organization.  The
key is to identify what you actually value in the software.  Newman used the
example of a CMS, where the value is largely in the creation and retrieval of
content.  The presentation of the content is not often a CMS’s strong suit;
hence, build a custom web front end that retrieves the content and displays it
in a way you fully control.

We chose Review Board in large part because of its rich support for displaying
and commenting on diffs.  In fact, the chunks of a diff are actually retrieved
after initial page load via Ajax calls.  At one point, before I read _Building
Microservices_, the team talked semi-jokingly (or maybe semi-seriously) about
extracting these pieces from Review Board to build our own system.  It seemed to
me like a pretty bad idea at the time.  But looking back, I think a couple weeks
of experimentation might have shown that something like this could actually have
been a maintainable alternative to forking the codebase and deeply changing the
UI.

And then there is a really great quote that I only really understand now.  I
won’t go into it, but it’s worth pondering:

> If you’ve decided to buy a product but the particular capabilities it
> provides aren’t that special to you, it might make more sense to change how
> your organization works rather than embark on complex customization.

Fail forward
------------

Opportunities to learn from failures can come up surprisingly often when you
know what to look for.  My team regularly checks our goals, both short and long
term, to ensure that we're having the most impact that we can.  We periodically
evaluate our systems' metrics to verify that we're measuring the right things.
We've stayed away from the temptation to heavily customize third-party
applications.  We strive for a product mindset at all times. These things aren't
always easy, but, thankfully, they seem much more natural to me than they did
five years ago.  There's really no substitute for experience, and there's no
more useful experience than failure.

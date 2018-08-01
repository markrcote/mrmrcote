---
title: "Decisions, decisions, decisions: Driving change at Mozilla"
date: 2017-09-07T14:15:38-04:00
categories: ["mozilla", "conduit"]
---
As the manager responsible for driving the decision and process behind
the move to Phabricator at Mozilla, I've been asked to write about my
recent experiences, including how this decision was implemented, what
worked well, and what I might have done differently.  I also have a
few thoughts about decision making both generally and at Mozilla
specifically.

Please note that these thoughts reflect only my personal opinions.
They are not a pronouncement of how decision making is or will be done
at Mozilla, although I hope that my account and ideas will be useful
as we continue to define and shape processes, many of which are still
raw years after we became an organization with more than a thousand
employees, not to mention the vast number of volunteers.

--------

Mozilla has used Bugzilla as both an issue tracker and a code-review
tool since its inception almost twenty years ago.  Bugzilla was
arguably the first freely available web-powered issue tracker, but
since then, many new apps in that space have appeared, both
free/open-source and proprietary.  A few years ago, Mozilla
experimented with a new code-review solution, named (boringly)
“MozReview”, which was built around Review Board, a third-party
application.  However, Mozilla never fully adopted MozReview, leading
to code review being split between two tools, which is a confusing
situation for both seasoned and new contributors alike.

There were many reasons that MozReview didn't completely catch on,
some of which I've mentioned in previous blog and newsgroup posts.
One major factor was the absence of a concrete, well-communicated,
and, dare I say, *enforced* decision.  The project was started by a
small number of people, without a clearly defined scope, no
consultations, no real dedicated resources, and no backing from upper
management and leadership.  In short, it was a recipe for failure,
particularly considering how difficult change is even in a perfect
world.

Having recognized this failure last year, and with the urging of some
people at the director level and above, my team and I embarked on a
process to replace both MozReview and the code-review functionality in
Bugzilla with a single tool and process.  Our scope was made clear: we
wanted the tool that offered the best mechanics for code-review at
Mozilla specifically.  Other bits of automation, such as
“push-to-review” support and automatic landings, while providing many
benefits, were to be considered separately.  This division of concerns
helped us focus our efforts and make decisions clearer.

Our first step in the process was to hold a consultation.  We
deliberately involved only a small number of senior engineers and
engineering directors.  Past proposals for change have faltered on
wide public consultation: by their very nature, you will get virtually
every opinion imaginable on how a tool or process should be
implemented, which often leads to arguments that are rarely settled,
and even when “won” are still dominated by the loudest voices—indeed,
the quieter voices rarely even participate for fear of being shouted
down.  Whereas some more proactive moderation may help, using a
representative sample of engineers and managers results in a more
civil, focussed, and productive discussion.

I would, however, change one aspect of this process: the people
involved in the consultation should be more clearly defined, and not
an ad-hoc group.  Ideally we would have various advisory groups that
would provide input on engineering processes.  Without such people
clearly identified, there will always be lingering questions as to the
authority of the decision makers.  There is, however, still much value
in *also* having a public consultation, which I'll get to shortly.

There is another aspect of this consultation process which was not
clearly considered early on: what is the honest range of solutions we
are considering? There has been a movement across Mozilla, which I
fully support, to maximize the *impact* of our work.  For my team, and
many others, this means a careful tradeoff of custom, in-house
development and third-party applications.  We can use entirely custom
solutions, we can integrate a few external apps with custom
infrastructure, or we can use a full third-party suite.  Due to the
size and complexity of Firefox engineering, the latter is effectively
impossible (also the topic for a series of posts).  Due to the size of
engineering-tools groups at Mozilla, the first is often ineffective.

Thus, we really already knew that code-review was a very likely
candidate for a third-party solution, integrated into our existing
processes and tools.  Some thorough research into existing solutions
would have further tightened the project's scope, especially given
Mozilla's particular requirements, such as Mercurial support, which
are in part due to a combination of scale and history.  In the end,
there are few realistic solutions.  One is Review Board, which we used
in MozReview.  Admittedly we introduced confusion into the app by
tying it too closely to some process-automation concepts, but it also
had some design choices that were *too* much of a departure from
traditional Firefox engineering processes.

The other obvious choice was Phabricator.  We had considered it some
years ago, in fact as part of the MozReview project.  MozReview was
developed as a monolithic solution with a review tool at its core, so
the fact that Phabricator is written in PHP, a language without much
presence at Mozilla today, was seen as a pretty big problem.  Our new
approach, though, in which the code-review tool is seen as just one
component of a pipeline, means that we limit customizations largely to
integration with the rest of the system.  Thus the choice of
technology is much less important.

The fact that Phabricator was virtually a default choice should have
been more clearly communicated both during the consultation process
and in the early announcements.  Regardless, we believe it is in fact
a very solid choice, and that our efforts are truly best spent solving
the problems unique to Mozilla, of which code review is not.

To sum up, small-scale consultations are more effective than open
brainstorming, but it's important to really pay attention to scope and
constraints to make the process as effective and empowering as
possible.

--------

Lest the above seem otherwise, open consultation does provide an
important part of the process, not in conceiving the initial solution
but in vetting it.  The decision makers cannot be “the community”, at
least, not without a *very* clear process.  It certainly can't be the
result of a discussion on a newsgroup.  More on this later.

Identifying the decision maker is a problem that Mozilla has been
wrestling with for years.  Mitchell has previously pointed out that we
have a dual system of authority: the module system and a management
hierarchy.  Decisions around tooling are even less clear, given that
the relevant modules are either nonexistent or sweepingly defined.
Thus in the absence of other options, it seemed that this should be a
decision made by upper management, ultimately the Senior Director of
Engineering Operations, Laura Thomson.  My role was to define the
scope of the change and drive it forward.

Of course since this decision affects every developer working on
Firefox, we needed the support of Firefox engineering management.
This has been another issue at Mozilla; the directorship was often
concerned with the technical aspects of the Firefox product, but there
was little input from them on the direction of the many supporting
areas, including build, version control, and tooling.  Happily I found
out that this problem has been rectified.  The current directors were
more than happy to engage with Laura and me, backing our decision as
well as providing some insights into how we could most effectively
communicate it.

One suggestion they had was to set up a small hosted test instance and
give accounts to a handful of senior engineers.  The purpose of this
was to both give them a heads up before the general announcement and
to determine if there were any major problems with the tool that we
might have missed.  We got a bit of feedback, but nothing we weren't
already generally aware of.

At this point we were ready for our announcement.  It's worth pointing
out again that this decision had effectively already been made,
*barring any major issues*.  That might seem disingenuous to some, but
it's worth reiterating two major points: (a) a decision like this,
really, any nontrivial decision, can't be effectively made by a large
group of people, and (b) we did have to be honestly open to the idea
that we might have missed some big ramification of this decision and
be prepared to rethink parts, or maybe even all, of the plan.

This last piece is worth a bit more discussion.  Our preparation for
the general announcement included several things: a clear
understanding of why we believe this change to be necessary and
desirable, a list of concerns we anticipated but did not believe were
blockers, and a list of areas that we were less clear on that could
use some more input.  By sorting out our thoughts in this way, we
could stay on message.  We were able to address the anticipated
concerns but not get drawn into a long discussion.  Again this can
seem dismissive, but if nothing new is brought into the discussion,
then there is no benefit to debating it.  It is of course important to
show that we understand such concerns, but it is equally important to
demonstrate that we have considered them and do not see them as
critical problems.  However, we must also admit when we do not yet
have a concrete answer to a problem, along with why we don't think it
needs an answer at this point—for example, how we will archive past
reviews performed in MozReview.  We were open to input on this issues,
but also did not want to get sidetracked at this time.

All of this was greatly aided by having some members of Firefox and
Mozilla leadership provide input into the exact wording of the
announcement.  I was also lucky to have lots of great input from Mardi
Douglass, this area (internal communications) being her specialty.
Although no amount of wordsmithing will ensure a smooth process, the
end result was a much clearer explanation of the problem and the
reasons behind our specific solution.

Indeed, there were some negative reactions to this announcement,
although I have to admit that they were fewer than I had feared there
would be.  We endeavoured to keep the discussion focussed, employing
the above approach.  There were a few objections we hadn't fully
considered, and we publicly admitted so and tweaked our plans
accordingly.  None of the issues raised were deemed to be
show-stoppers.

There were also a very small number of messages that crossed a line of
civility.  This line is difficult to determine, although we have often
been too lenient in the past, alienating employees and volunteers
alike.  We drew the line in this discussion at posts that were
disrespectful, in particular those that brought little of value while
questioning our motives, abilities, and/or intentions.  Mozilla has
been getting better at policing discussions for toxic behaviour, and I
was glad to see a couple people, notably Mike Hoye, step in when
things took a turn for the worse.

There is also a point in which a conversation can start to go in
circles, and in the discussion around Phabricator (in fact in response
to a progress update a few months after the initial announcement) this
ended up being around the authority of the decision makers, that is,
Laura and myself.  At this point I requested that a Firefox
engineering director, in this case Joe Hildebrand, get involved and
explain his perspective and voice his support for the project.  I wish
I didn't have to, but I did feel it was necessary to establish a
certain amount of credibility by showing that Firefox leadership was
both involved with and behind this decision.

Although disheartening, it is also not surprising that the issue of
authority came up, since as I mentioned above, decision making has
been a very nebulous topic at Mozilla.  There is a tendency to invoke
terms like “open” and “transparent” without in any way defining them,
evoking an expectation that everyone shares an understanding of how we
ought to make decisions, or even how we used to make decisions in some
long-ago time in Mozilla's history.  I strongly believe we need to lay
out a decision-making framework that values openness and transparency
but also sets clear expectations of how these concepts fit into the
overall process.  The most egregious argument along these lines that
I've heard is that we are a “consensus-based organization”.  Even if
consensus were possible in a decision that affects literally hundreds,
if not thousands, of people, we are demonstrably not consensus-driven
by having both module and management systems.  We do ourselves a
disservice by invoking consensus when trying to drive change at
Mozilla.

On a final note, I thought it was quite interesting that the topic of
decision making, in the sense of product design, came up in the recent
CNET article on Firefox 57.  To quote Chris Beard, “If you try to make
everyone happy, you're not making anyone happy.  Large organizations
with hundreds of millions of users get defensive and try to keep
everybody happy.  Ultimately you end up with a mediocre product and
experience.” I would in fact extend that to trying to make all
Mozillians happy with our internal tools and processes.  It's a scary
responsibility to drive innovative change at Mozilla, to see where we
could have a greater impact and to know that there will be resistance,
but if Mozilla can do it in its consumer products, we have no excuse
for not also doing so internally.

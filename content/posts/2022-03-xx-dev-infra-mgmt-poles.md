---
title: "The Management Poles of Developer Infrastructure Teams"
date: 2022-03-04T17:35:20-05:00
draft: true
---
Over the past couple years as I've managed multiple developer-infrastructure
teams and have started to build new ones, I've found some tensions that are hard
to resolve.  In my current mental model (I love [mental models](https://shopify.engineering/modelling-developer-infrastructure-teams)!),
I have found that there are three poles that have a natural tension and are thus
tricky to balance: management capacity, system and domain expertise, and
road maps.  I'm going to discuss details of these poles and some
strategies I've tried to manage them.

## What's special about dev infra teams?

Although this model likely can apply to any software-development team, the
nature of developer infrastructure makes this situation particularly acute
for managers in our field.  These are some of the specific challenges faced in
dev infra:

- Engineering managers have a lot on their plates.  For whatever reason, infra
  teams usually lack dedicated product managers, so we often have to step in to
  fill that gap.  Similarly, we are responsible for tasks that usually fall to UX
  experts, such as doing user research.

- There is a lot of maintenance and support.  Teams are responsible for keeping
  multiple critical systems online with hundreds or thousands of users,
  generally with a relatively small team of 6-8 developers.  In addition, we
  often get a lot of support requests, which is part of the cost of developing
  in-house software that has no extended community outside the company.

- As teams tend to organize around particular phases in the development
  workflow, or sometimes specific technologies, there is a high degree of domain
  expertise that is developed over time by all its members and informs the
  team's road map.

## The three poles

The dev infra management poles I've modelled are tensions, much like that
between product and engineering.  They can't, I don't believe, all be solved at
the same time—and _perhaps_ they shouldn't be.  We balance them according to
current needs and context and adapt as necessary.  For this balancing act, it
behooves us to make sure we understand the nature of these poles.

### Management support

Supporting developers in their career growth is an important function of any
engineering manager.  This is one of the reasons we keep team sizes around 6-8
ICs; more reports than that will stretch a manager's capacity to keep feedback
loops tight.
  
Every engineering team has to deal with the issue of management capacity.  Good
managers are hard to find, and even the best manager adds a bit of overhead to a
team's impact.  At the same time, a team will suffer if their manager has too
many reports, which is compounded by the PM and UX duties that dev infra
managers sometimes have to take on.  Ideally, an individual team has one manager
and as many reports as feasible.  Depending on the experience of the manager, I
agree with [Will Larson](https://lethain.com/about/)'s recommendation of 6-8
reports per manager.

We want to maximize the number of reports per manager.  This expands the team's
impact and make the best use of a managers, a scarce and expensive resource.  Where this
gets complicated is balancing the scope and domain of individual dev
infra teams and of the whole dev infra org.  This tension is a direct result of
the need for specific system and domain expertise on dev infra teams.

### System and domain expertise

As mentioned above, in dev infra we tend to build teams around domains that
represent phases in the development work flow, or occasionally around specific
critical technologies.  It is important that each team has domain-specific
knowledge both of the area generally, e.g., deployment and the specific systems
involved.  Despite this focus, the scope of and opportunities in a given area
can be quite broad, and the associated systems grow in size and complexity.  In
time, teams can be split when their scope grows too big to handle within a
single team.

Expertise in a team's systems is crucial just to keep everything humming along.
As with any long-running software application, dependencies need to be managed,
underlying infra has to be occasionally migrated, and outages and other
incidents must be investigated and root causes solved. Furthermore, at any large
organization, dev infra services can be under a lot of load relative to the size
of the teams responsible for them, and some will require on-call schedules in
case a critical system breaks during an emergency (finding out the deployment
tool is down when you're trying to ship a security fix is, let's just say, not a
great experience for anyone).

A larger team means less individual on-call time, more hands for support and
maintenance, and more project work.  As teams expand their domain knowledge,
more opportunities are discovered for increasing the impact of the services for
which the team is responsible.  The team will naturally be driven to constantly
improve the developer experience of the development phase or technology for
which they are responsible.  This, however, risks a disconnect with the greatest
opportunities for impact across dev infra as a whole.

### Road maps

Specializing developer-infrastructure teams in particular domains is crucial for
both maintenance and future investments.  Team road maps and visions will
improve and expand upon existing offerings: smoothing interfaces, expanding
functionality, scaling up existing solutions, and looking for new opportunities
to impact development in their domain.  The focus can make a big difference to
developers during particular phases of their workflow: providing automation and
feedback while writing code, speeding up CI execution, avoiding deployment
backlogs, more effectively monitoring services, etc.

This focus comes with a cost: the biggest impact we can have on development at
any given time changes.  When dev infra teams are first created, there is
usually a lot of low-hanging fruit—obvious friction at different points in the
development workflow—so multiple teams can broadly improve the developer
experience in parallel.  At some point, however, some aspects of the workflow
will be much smoother than others.  Maybe CI times have finally dropped to 5
minutes.  Maybe deploys rarely need attention after being initiated.  At a large
organization, there will always be edge cases and bugs and special requirements
in every area, but their impact will be increasingly limited when compared to
engineering needs as a whole.

At this point, there may be an opportunity for a large new initiative that will
radically impact development in a particular way.  There may be a few.  But it's
unlikely that there will be the need for radical changes across all domains.
Furthermore, there may be unexplored opportunities, new domains that haven't
previously been explored, for which no team has been assembled.  These can be
hard to spot if the majority of developers and managers are focused on existing
well-defined scopes.

## The balancing act

Here's the part where I confess that I don't have a single amazing solution to
balance management capacity, system maintenance and expertise, and high-level
goals. Likely there are a variety of solutions that can be applied and none are
perfect. Here's a few ideas I've thought and experimented about:

### Temporarily assign people from one team to a project on another

If we've decided that the best impact for our org at this moment is concentrated
in the work of a particular team, call it Team A, and if Team A's manager
capacity is maxed out, then a direct way to get more stuff done is to take a few
people from another team (Team B) and assign them to the Team A's project(s).
This has some other benefits as well: it increases the number of people with
familiarity in Team A's systems, and people sometimes like to change up with
they're working on.

The drawbacks of this approach are clear when we look at the management poles,
however. Should Team B's people stay on the support rotations for their "home"
team? From a technical expertise view, they are important to keep the lights on
in the systems they're familiar with. Leaving them on such rotations prevents
total focus on the new team, however, and at a minimum extends onboarding time.

Furthermore, managing someone who isn't working with others on your team is
challenging; there's a reason matrix management isn't super popular. It can
require extra effort on behalf of managers, and the IC can feel that they aren't
getting sufficient support. They can end up feeling disconnected from both their
home team and the new one.

### Have a whole team contribute to another team's goals

We can mitigate at least the last problem above if we have an entire team
(continuing the above nomenclature, Team B) work on the systems that another
team (Team A) owns. This allows members of Team B to leverage their existing
working relationships with each other, and the manager doesn't have to split
their attention between two teams. This arrangement can work well if there is a
focused project in Team A's domain that somehow involves some of Team B's domain
expertise.

This is, of course, a very blunt instrument, in that no project work will get
done on Team B's systems, which themselves still need to be maintained. There is
also a risk of demotivating the members of Team B, who may feel that their
domain and systems isn't important (although this can be mitigated to some
extent if the project benefits or requires their domain expertise).

### Tiger team

A third option we've tried out is a [tiger
team](https://www.lucidchart.com/blog/what-is-a-tiger-team): "a specialized,
cross-functional team brought together to solve or investigate a specific
problem or critical issue". People from multiple teams form a new, temporary
team for a single project, often prototyping a new idea. Usually the team
operates in a fast-paced, autonomous way towards a very specific goal, so
management oversight is fairly limited. By definition, most people on a tiger
team don't usually work together, so the home/new team dichotomy is sidestepped,
or at least very deliberately managed, and the focus of the team means that
maintenance, support, and other such ongoing tasks are put aside for the
duration of the team's existence.

Clearly this leaves the other teams shorthanded for a period of time, and the
question of how work will be carried on the deliverables of the tiger team must
be solved, either by having an existing team take it over, or a new, long-lived
team formed.

## No perfect solutions

From what I can tell, there is no perfect solution to balance the three poles of
management capacity, system maintenance and domain expertise, and high-level
goals. Each situation is unique, and trade-offs have to be judged and taken
deliberately. I would love to hear other stories of such balancing acts!

---
title: "The Management Poles of Developer Infrastructure Teams"
date: 2022-03-04T17:35:20-05:00
draft: true
---
Over the past couple years as I've managed multiple developer-infrastruture
teams and have started to build new ones, I've found some tensions that are hard
to resolve. In my current mental model, I see three poles that are tricky to
balance: management capacity, maintenance tasks and system expertise, and
higher-level goals. 

# What's special about dev infra teams?

Although this model likely can apply to any software-development team, the
nature of developer-infrastructure teams makes this situation particularly acute
for managers in this area. These are some of the specific challenges faced in
dev infra:

- Engineering managers have a lot on their plates. For whatever reason, infra
  teams usually lack dedicated product managers, so we often have to step in to
  fill that gap. Similarly, we are responsible for tasks that usually fall to UX
  experts, such as doing user research.

- Dev infra teams are usually responsible for multiple applications that are
  critical to engineering. A team tends to cover a specific area, such as test
  infrastructure or developer environments, that has many moving parts.

# The three poles

## Management capacity

The first balancing factor in organizing a dev infra team of teams is common to
any team but needs to be mentioned nonetheless: management capacity. Good
managers are hard to find, and even the best manager adds a bit of overhead to a
team's impact. At the same time, a team will suffer if their manager has too
many reports, which is compounded by the PM and UX duties that dev infra
managers sometimes have to take on. Ideally, an individual team has one manager
and as many reports as feasible. Depending on the experience of the manager,
I agree with Will Larson's recommendation of 6-8 reports per manager, erring on
the lower side if possible.

Maximizing the number of reports per manager is a fairly obvious idea. Where it
gets complicated is balancing this with the scope and domain of individual dev
infra teams and of the whole dev infra org.

## System maintenance and expertise

In dev infra teams, we tend to build teams around certain domains that represent
phases in the development work flow, or occasionally around specific critical
technologies. It is important that each team has domain-specific knowledge both
of the area generally (e.g. deployment) and the specific systems involved (e.g.,
at Shopify, Shipit). The scope and opportunities in a given area can be quite
broad, and the associated systems tend to grow in size and complexity over time.
In time, teams can be split when their scope grows too big to handle within a
single team.

Expertise in a team's systems is crucial just to keep everything humming along.
As with any long-running software application, dependencies need to be managed,
underlying infra is occasionally migrated, and outages and other incidents have
to be investigated and solved. Furthermore, at any large organization, dev infra
services can be under a lot of load relative to the size of the team responsible
for them, and some will require on-call schedules in case a critical system
breaks during an emergency (finding out the deployment tool is down when you're
trying to ship a security fix is, let's just say, not a great experience).

A larger team means less individual on-call time, and more hands for support and
maintenance. However, expertise in a system is rarely gained by just reading
through code and prodding it a bit through dependency upgrades and such. The
real experience comes in making changes to really understand how all the pieces
fit together. This means, somewhat paradoxically, that a system has to regularly
change for it to be understood.

The more people on the team, the more changes have to be made to ensure a
common level of system knowledge. Furthermore, as teams expand their domain
knowledge, more opportunities are discovered for increasing the impact of the
services for which the team is responsible. In other words, a team specific to a
particular phase of the development workflow will naturally be driven to
constantly improve the developer experience of that phase. However, there risks
a disconnect with the greatest opportunities for impact across dev infra as a
whole.

## High-level goals

Specializing developer-infrastructure teams in particular domains is crucial for
both maintenance and future investments. Road maps and visions will improve and
expand on existing offerings: smoothing interfaces, expanding
functionality, and scaling up existing solutions, and looking for new
opportunites to impact development in their domain. The focus can make a big
difference to developers during particular phases of their workflow: providing
automation and feedback while writing code, speeding up CI execution, more
reliably shipping PRs, more effectively monitoring services, etc.

This focus comes with a cost, however: the biggest impact we can have on
development at any given time changes. When dev infra teams are first created,
there are usually many low-hanging fruit, aggravating friction at multiple
points in the development workflow, so many teams can simulatenously greatly
improve developer experience. At some point, however, some systems will be "good
enough" compared to others. Maybe CI times have finally dropped to 5 minutes.
Maybe deploys rarely need attention after being initiated. At a large
organization, in any area there will always be edge cases and bugs and special
requirements, but their impact will be increasingly limited compared to
engineering as a whole.

At this point, there may be an opportunity for a large new initiative that will radically
impact developmet in a particular way. There may be a few. But it's unlikely
that there will be the need for radical changes across all domains. Furthermore,
there may be unexplored opportunities, new domains that haven't previously been
explored, for which no team has been assembled. These can be hard to spot if the
majority of developers and managers are focused on existing well-defined areas.

# The balancing act

Here's the part where I confess that I don't have a single amazing solution to balance
management capacity, system maintenance and expertise, and high-level goals.
Likely there are a variety of solutions that 
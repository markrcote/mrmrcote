---
title: "The Management Poles of Developer Infrastructure Teams"
date: 2022-03-04T17:35:20-05:00
draft: true
---
Over the past couple years as I've managed multiple developer-infrastruture teams and have started to build new ones, I've found some tensions that are hard to resolve. In my current mental model, I see three poles that are tricky to balance: management capacity, maintenance tasks and system expertise, and higher-level goals. 

Although this model likely can apply to any software-development team, the nature of developer-infrastructure teams makes this situation particularly acute for managers in this area. These are some of the specific challenges faced in dev infra:

- Engineering managers have a lot on their plates. For whatever reason, infra teams usually lack dedicated product managers, so we often have to step in to fill that gap. Similarly, we are responsible for tasks that usually fall to UX experts, such as doing user research.

- Dev infra teams are usually responsible for multiple applications that are critical to engineering. A team tends to cover a specific area, such as test infrastructure or developer environments, that has many moving parts.






Management capacity

Maintenance and system expertise

- Systems need maintenance:
 - new features from customer asks
 - dependency upgrades (packages, underlying infra)
 - incident resolution

- More people means less on-call, more hands to do maintenance
- But expertise in best gained by working in the code. Not always easy to justify changes in terms of high-level priorities, plus changes risk destabilization

Broader goals

- Specialized teams tend to think in terms of their own projects/products
- One team's systems may not need work as badly as others
- New dev-infra problems may not fit neatly into any existing team


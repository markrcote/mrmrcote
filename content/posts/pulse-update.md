---
title: "Pulse update"
date: 2015-02-16T22:10:51-05:00
categories: ["mozilla", "pulse"]
---
After languishing for a few years, [Pulse][] got a burst of interest and
development in 2014.  Since I first heard of it, I've found
the idea of a central message bus for the goings-on in Mozilla's
various systems rather intruiging, and I'm excited to have been able
to grow it over the last year.

Pulse falls into that class of problem that is a result of, to borrow
from a past Mozilla leader, our tendency to make our lives difficult, that
is, to work in the open.  Using RabbitMQ as a generic event stream is
nothing special; Mozilla's use of it as an *open system* is, I
believe, completely unique.

Adapting a system intended for private networks into a public service
always results in fascinating problems.  Pulse has a decent
permission-control system, but it's not designed for self service.
It is also very trusting of its users, who can easily overwhelm
the system by just subscribing to streams and never consuming the
messages.

The solution to both these problems was to design a management
application: [PulseGuardian][].  Via Persona, it handles account
management, and it comes with a service that monitors Pulse's queues.
Since we *presume* users are not malicious, it sends a friendly
warning when it notices a queue growing too large, but if ignored it
will eventually kill the queue to save the system.

If you build it, they will come, or so says some movie I've never
seen, but in this case it appears to be true.  [TaskCluster][] has
moved whole-hog over to Pulse for its messaging needs, and the devs
wrote a really nice web app for [inspecting live messages][].
[MozReview][] is using it for code-review bots and autolanding
commits.  [Autophone][] is exploring its use for providing [Try][]
support to non-BuildBot-based testing frameworks.

Another step for Pulse beyond the prototype phase is a proper
library.  The existing [mozillapulse][] Python library works decently,
aside from some [annoying problems][], but it
suffers from a lack of extensibility, and, I'm beginning to believe,
should be based directly on a lower-level amqp or RabbitMQ-specific
Python package and not the strange, overly generic [kombu][] messaging
library, in part because of the apparent lack of [confirm channels][]
in kombu.  We're looking into taking ideas from TaskCluster's Pulse
usage in [bug 1133602][].

Recently I presented the State of Pulse to the [A-Team][].  I should
do that as a general brownbag at some point, but, until then, you can
look at the [slides][].


[Pulse]: https://pulse.mozilla.org
[PulseGuardian]: https://github.com/mozilla/pulseguardian
[TaskCluster]: http://docs.taskcluster.net/
[inspecting live messages]: https://tools.taskcluster.net/pulse-inspector/
[MozReview]: http://mozilla-version-control-tools.readthedocs.org/en/latest/mozreview.html
[Autophone]: https://wiki.mozilla.org/Auto-tools/Projects/AutoPhone
[Try]: https://wiki.mozilla.org/ReleaseEngineering/TryServer
[mozillapulse]: https://hg.mozilla.org/automation/mozillapulse/
[annoying problems]: https://bugzilla.mozilla.org/show_bug.cgi?id=1079515
[kombu]: http://kombu.readthedocs.org/en/latest/
[confirm channels]: https://bugzilla.mozilla.org/show_bug.cgi?id=1068444
[bug 1133602]: https://bugzilla.mozilla.org/show_bug.cgi?id=1133602
[A-Team]: https://wiki.mozilla.org/Auto-tools
[slides]: http://slides.com/mcote/pulse

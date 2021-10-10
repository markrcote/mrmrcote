---
title: "Phabricator and Lando November Update"
date: 2017-11-17T10:36:00-05:00
categories: ["mozilla", "conduit", "phabricator"]
---
With work on Phabricator–BMO integration wrapping up, the development
team’s focus has switched to the new automatic-landing service that
will work with Phabricator. The new system is called “Lando” and
functions somewhat similarly to MozReview–Autoland, with the biggest
difference being that it is a standalone web application, not tightly
integrated with Phabricator. This gives us much more flexibility and
allows us to develop more quickly, since working within extension
systems is often painful for anything nontrivial.

Lando is split between two services: the landing engine, “lando-api”,
which transforms Phabricator revisions into a format suitable for the
existing autoland service (called the “transplant server”), and the
web interface, “lando-ui”, which displays information about the
revisions to land and kicks off jobs. We split these services partly
for security reasons and partly so that we could later have other
interfaces to lando, such as command-line tools.

When I last posted [an update][] I included an early screenshot of
lando-ui. Since then, we have done some user testing of our prototypes
to get early feedback. Using a great article,
“[Test Your Prototypes][]: How to Gather Feedback and Maximise
Learning”, as a guide, we took our prototype to some interested future
users. Refraining from explaining anything about the interface and
providing only some context on how a user would get to the
application, we encouraged them to think out loud, explaining what the
data means to them and what actions they imagine the buttons and
widgets would perform. After each session, we used the feedback to
update our prototypes.

These sessions proved immensely useful. The feedback on our third
prototype was much more positive than on our first prototype. We
started out with an interface that made sense to us but was confusing
to someone from outside the project, and we ended with one that was
clear and intuitive to our users.

For comparison, this is what we started with:

![First lando mockup](/images/lando-mockup-1.png)

And here is where we ended:

![Final lando mockup](/images/lando-mockup-final.png)

A partial implementation of the third prototype, with a few more small
tweaks raised during the last feedback session, is currently on
<http://lando.devsvcdev.mozaws.net/revisions/D6>. There are currently
some duplicated elements there just to show the various states; this
redundant data will of course be removed as we start filling in the
template with real data from Phabricator.

Phabricator remains in a pre-release phase, though we have some people
now using it for mozilla-central reviews. Our team continues to use it
daily, as does the NSS team. Our implementation has been very stable,
but we are making a few changes to our original design to ensure it
stays rock solid. Lando was scheduled for delivery in October, but due
to a few different delays, including being one person down for a
while and not wanting to launch a new tool during the flurry of the
Firefox 57 launch, we’re now looking at a January launch date. We
should have a working minimal version ready for Austin, where we have
scheduled a [training session][] for Phabricator and a Lando demo.

[an update]: https://mrcote.info/blog/2017/07/11/phabricator-update/
[Test Your Prototypes]: https://www.interaction-design.org/literature/article/test-your-prototypes-how-to-gather-feedback-and-maximise-learning
[training session]: https://austinyallhands2017.sched.com/event/Cw2D/124-phabricatorlando-training

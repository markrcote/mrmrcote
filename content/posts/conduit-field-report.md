---
title: "Conduit Field Report, March 2017"
date: 2017-03-14T12:44:28-04:00
categories: ["mozilla", "conduit"]
---
For background on Conduit, please see the [previous post][] and the
[Intent to Implement][].

Autoland
========

We kicked off Conduit work in January starting with the new Autoland
service.  Right now, much of the Autoland functionality is located in
the MozReview Review Board extension: the permissions model, the
rewriting of commit messages to reflect the reviewers, and the user
interface.  The only part that is currently logically separate is the
"transplant service", which actually takes commits from one repo
(e.g. reviewboard-hg) and applies it to another (e.g. try,
mozilla-central).  Since the goal of Conduit is to decouple all the
automation from code-review tools, we have to take everything
that's currently in Review Board and move it to new, separate
services.

The original plan was to switch Review Board over to the new Autoland
service when it was ready, stripping out all the old code from the
MozReview extension.  This would mean little change for MozReview
users (basically just a new, separate UI), but would get people using
the new service right away.  After Autoland, we'd work on the
push-to-review side, hooking that up to Review Board, and then extend
both systems to interface with BMO.  This strategy of incrementally
replacing pieces of MozReview seemed like the best way to find bugs as
we went along, rather than a massive switchover all at once.

However, progress was a bit slower than we anticipated, largely due to
the fact that so many things were new about this project (see below).
We want Autoland to be fully hooked up to BMO by the end of June, and
integrating the new system with both Review Board and BMO as we went
along seemed increasingly like a bad idea.  Instead, we decided to put
BMO integration first, and then follow with Review Board later (if
indeed we still want to use Review Board as our rich-code-review
solution).

This presented us with a problem:  if we wouldn't be hooking the new
Autoland service up to Review Board, then we'd have to wait until the
push service was also finished before we hooked them both up to BMO.
Not wanting to turn everything on at once, we pondered how we could
still launch new services as they were completed.

Moving to the other side of the pipeline
========================================

The answer is to table our work on Autoland for now and switch to the
push service, which is the entrance to the commit pipeline.  Building
this piece first means that users will be able to push commits to BMO
for review.  Even though they would not be able to Autoland them right
away, we could get feedback and make the service as easy to use as
possible.  Think of it as a replacement for [bzexport][].

Thanks to our new Scrum process (see also below), this priority
adjustment was not very painful.  We've been shipping Autoland code
each week, so, while it doesn't do much yet, we're not abandoning any
work in progress or leaving patches half finished.  Plus, since this
new service is also being started from scratch (although involving lots
of code reuse from what's currently in MozReview), we can apply the
lessons we learned from the last couple months, so we should be
moving pretty quickly.

Newness
=======

As I mentioned above, although the essence of Conduit work right now
is decoupling existing functionality from Review Board, it involves a
lot of new stuff.  Only recently did we realize exactly *how much* new
stuff there was to get used to!

New team members
----------------

We welcomed Israel Madueme to our team in January and threw him right
into the thick of things.  He's adapted tremendously well and started
contributing immediately.  Of course a new team member means new team
dynamics, but he already feels like one of us.

Just recently, we've stolen dkl from the BMO team, where he's been
working since joining Mozilla 6 years ago.  I'm excited to have a
long-time A-Teamer join the Conduit team.

A new process
-------------

At the moment we have five developers working on the new Conduit
services.  This is more people on a single project than we're usually
able to pull together, so we needed a process to make sure we're
working to our collective potential.  Luckily one of us is a certified
ScrumMaster.  I've never actually experienced Scrum-style development
before, but we decided to give it a try.

I'll have a lot more to say about this in the future, as we're only
just hitting our stride now, but it has felt really good to be working
with solid organizational principles.  We're spending more time in
meetings than usual, but it's paying off with a new level of focus and
productivity.

A new architecture
------------------

Working within Review Board was pretty painful, and the MozReview
development environment, while amazing in its breadth and coverage,
was slow and too heavily focussed on lengthy end-to-end tests.  Our new
design follows more of a microservice-based approach.  The Autoland
verification system (which checks users permissions and ensures
that commits have been properly reviewed) is a separate service, as is
the UI and the transplant service (as noted above, this last part was
actually one of the few pieces of MozReview that was already
decoupled, so we're one step ahead there).  Similarly, on the other
side of the pipeline, the commit index is a separate service, and the
review service may eventually be split up as well.

We're not yet going whole-hog on microservices—we don't plan, for
starters at least, to have more than 4 or 5 separate services—but we're
already benefitting from being able to work on features in parallel
and preventing runaway complexity.  The book [Building Microservices][]
has been instrumental to our new design, as well as pointing out
exactly why we had difficulties in our previous approach.

New operations
--------------

As the A-Team is now under Laura Thomson, we're taking advantage of
our new, closer relationship to CloudOps to try a new deployment and
operations approach.  This has freed us of some of the constraints of
working in the data centre while letting us take advantage of a proven
toolchain and process.

New technologies
----------------

We're using Python 3.5 (and probably 3.6 at some point) for our new
services, which I believe is a first for an A-Team project.  It's new
for much of the team, but they've quickly adapted, and we're now
insulated against the [2020 deadline][] for Python 2, as well as
benefitting from the niceties of Python 3 like better Unicode support.

We also used a few technologies for the Autoland service that are new
to most of the team: [React][] and [Tornado][].  While the team found
it interesting to learn them, in retrospect using them now was
probably a case of premature optimization.  Both added complexity that
was unnecessary right now.  React's URL routing was difficult to get
working in a way that seamlessly supported a local, Docker-based
development environment and a production deployment scenario, and
Tornado's asynchronous nature led to extra complexity in automated
tests.  Although they are both fine technologies and provide scalable
solutions for complex apps, the individual Conduit services are
currently too small to really benefit.

We've learned from this, so we're going to use [Flask][] as the back
end for the push services (commit index and review-request generator),
for now at least, and, if we need a UI, we'll probably use a
relatively simple template approach with JavaScript just for
enhancements.

Next
====

In my next post, I'm going to discuss our approach to the push
services and more on what we've learned from MozReview.


[previous post]: https://mrcote.info/blog/2017/01/13/project-conduit/
[Intent to Implement]: https://groups.google.com/forum/#!topic/mozilla.tools/yofQCwT7AKY
[bzexport]: https://hg.mozilla.org/hgcustom/version-control-tools/file/tip/hgext/bzexport
[building Microservices]: http://shop.oreilly.com/product/0636920033158.do
[2020 deadline]: http://legacy.python.org/dev/peps/pep-0373/
[React]: https://facebook.github.io/react/
[Tornado]: http://www.tornadoweb.org/
[Flask]: http://flask.pocoo.org/

---
title: "BMO in 2015"
date: 2016-01-07T20:20:34-05:00
categories: ["mozilla", "bmo", "bugzilla"]
---
It's been a whole year since my [last BMO update][], partly because I've
been busy with MozReview (and [blogging a lot about it][]), and partly
because the BMO team got distracted from our goals by a few sudden
priority changes, which I'll get to later in this post.

Plans from 2014
===============

Even with some large interruptions, we fully achieved three of our
five goals for the year and made good progress on a fourth.

Alternative Bug Views
---------------------

Have you tried out the new [modal UI][]?  Although not completely
finished (it lacks a few features that the standard UI has), it's very
usable.  I don't remember the last time I had to switch back, and I've
been using it for at least 6 months.  Bonus: gone is the intermediate
page when you change a bug's product, a gripe from time immemorial!

Even though there are still a large number of controls, the new UI is
a lot more streamlined.  glob gave a brief presentation at a
[Mozilla Project Meeting][] in November if you'd like to learn more.

The part we haven't yet undertaken is building on this new framework
to provide alternate views of bug data depending on what the user is
trying to accomplish.  We want to experiment with stripping down the
presented data to only what is needed for a particular task,
e.g. developing, triaging, approving, etc.  The new UI is a lot more
flexible than the old, so in 2016 we'll build out at least one new
task-centric view.

GitHub Authentication
---------------------

If you haven't noticed, you can log into BMO via GitHub.  If you've
never used BMO before, you'll be prompted to set up an account after
authenticating.  As with Persona, only users with no special
privileges (i.e. not admins nor people in security groups) can log in
via GitHub.

Auth Delegation
---------------

Originally designed to smooth the process of logging into Review
Board, [auth delegation][] for API keys is actually a general-use
feature that greatly improves the user experience, not to mention
security, of third-party apps by allowing them to delegate
authentication to BMO.  There's now no reason for apps to directly ask
for your BMO credentials!

MozReview Details
-----------------

There's now a panel just above the attachments table that shows all
the MozReview commits associated with the displayed bug along with a
bit of other info:

![BMO MozReview table](/images/bmo-mozreview-table.png)

We're currently sorting out a single method to display other relevant
information, notably, status of reviews, and then we'll add that to
this table.

Improved Searchability
----------------------

This is the big item we haven't made much progress on.  We've got a
plan to mirror some data to an Elasticsearch cluster and wire it into
Quick Search.  We've even started on the implementation, but it's not
going to be ready until mid-2016.  It will increase search speeds,
understandably one of the more common complaints about BMO.


Curve balls
===========

We had two sets of surprises in 2015.  One was work that ended up
consuming more time than we had expected, and the other was important
work that suddenly got a big priority boost.

BMO Backup in AWS
-----------------

The first is that we moved the BMO failover out of a data center in
Phoenix and into the cloud.  IT did most of the work, but we had to
make a series of changes to BMO to facilitate the move.  We also had a
lot of testing to do to.  The upside is that our new failover system
has had more testing than our old one had for quite some time!

Hardened Security
-----------------

In August we found out that an attacker had compromised a privileged
BMO account, using a combination of a weak, reused password and an
exploit in another web site.  In addition to a huge forensics effort
from the great security folks at Mozilla, the BMO team implemented a
number of security enhancements to BMO, most notably
[two-factor authentication][].  This work naturally took high priority
and is the main reason for the slippage of our big 2015 goals.  Here's
to a more secure 2016!


Other Stuff
===========

As usual, the BMO team rolled out a pile of smaller fixes, enhancements,
improvements, and new features.  A few notable examples include

* The [guided bug-entry form][] got a nice refresh.  This is the form
  that users without the `editbugs` permission, i.e. new users, see
  when entering bugs.  You can always get to it via the "Switch to the
  Bugzilla helper" link at the buttom of the advanced bug-entry form.
  Note that if you're an employee, you've been given `editbugs` by
  default, so you've likely never seen the guided form.  Check it
  out—Bugzilla might be friendlier to new contributors than you expect.

* [The platform settings][] for new bugs now default to all
  hardware and OSes, with a "Use my platform" button to easily set this to
  the reporter's system parameters.  This should help clear up some
  confusion between the reporter's platform versus the platform the
  bug applies to.

* The ability to [block requests][] for review, feedback, and needinfo.

* The [preferences page][] is now better organized.

* HTML bugmail has [microdata][] to make GMail display a "View bug"
  button.  Thanks to Ed Morley for the patch!

You can always find the exhaustive list of recent changes to BMO
[on the wiki][] or on the [mozilla.tools.bmo][] group/mailing list.


[last BMO update]: https://mrcote.info/blog/2015/01/07/bmo-2014-update-part-ii/
[blogging a lot about it]: https://mrcote.info/blog/categories/mozreview/
[modal UI]: https://globau.wordpress.com/2015/03/31/bmo-new-look/
[Mozilla Project Meeting]: https://air.mozilla.org/mozilla-weekly-project-meeting-20151116/
[auth delegation]: https://bmo.readthedocs.org/en/latest/integrating/auth-delegation.html
[two-factor authentication]: https://globau.wordpress.com/2015/09/01/happy-bmo-push-day-158/
[guided bug-entry form]: https://bugzilla.mozilla.org/enter_bug.cgi?format=guided
[The platform settings]: https://globau.wordpress.com/2015/04/14/changing-the-default-platform-and-operating-system-on-bugzilla-mozilla-org-to-all-all/
[block requests]: https://globau.wordpress.com/2015/03/10/happy-bmo-push-day-130/
[on the wiki]: https://wiki.mozilla.org/BMO/Recent_Changes
[microdata]: https://bugzilla.mozilla.org/show_bug.cgi?id=1102364
[mozilla.tools.bmo]: https://wiki.mozilla.org/BMO#More_Information_about_BMO
[preferences page]: https://bugzilla.mozilla.org/userprefs.cgi

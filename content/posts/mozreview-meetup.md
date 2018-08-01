---
title: "MozReview Meet-Up"
date: 2015-09-14T12:26:53-07:00
categories: ["mozilla", "mozreview"]
---
Two weeks ago the MozReview developers got together to do some focussed
hacking.  It was a great week, we got a lot of stuff done, and we
clarified our priorities for the coming months.  We deployed several
new features and improvements during the week, and we made good
progress on several other goals.

For this week, we actually opted to not go to a Mozilla office and
instead rented an AirBNB in Montreal—our own little hacker house!  It
was a great experience.  There was no commuting (except for me, since
I live here and opted to sleep at my house) and no distractions.  One
evening when we were particularly in the zone, we ordered a bunch of
pizzas instead of going out, although we made sure to take breaks and
go outside regularly on all the other days, in order to refresh our
minds.  Five out of five participants said they'd do it again!

See also [dminor's post][] about the week, with a bit more detail on
what he worked on.

What we pushed out
==================

My main contribution to the week was finally switching MozReview to
Bugzilla's API-key-based authentication-delegation system.  I'd been
working on this for the last couple months when I found time, and it
was a big relief to finally see it in action.  I won't go into detail
here, since I've [already blogged][] about it and [announced it][] to
dev.platform.

gps, working amazingly fast as always, got API-key support working
[on the command line][] almost immediately after UI support was deployed.
No more storing credentials or login cookies!

Moving on, we know the MozReview's UI could... stand some improvement,
to say the least.  So we split off some standalone work from Autoland
around clarifying the status of reviews.  Now in the commit table
you'll see something like this:

<img src="/images/screen-shot-new-review-indicators.png" />

This warrants a bit of explanation, since we're reusing some terms
from Bugzilla but changing them a little.

r+ indicates at least one ship-it, subject to the following:

* If the author has L3 commit access, the ship-it review can be
   from anyone.
* If the author does not have L3 commit access, at least one ship-it
  is from a reviewer with L3 access.

The reason for the L3 requirement is for Autoland.  Since a human
won't necessarily be looking at your patch between the time that a
review is granted and the commit landing in tree, we want some checks
and balances.  If you have L3 yourself, you're trusted enough to not
require an L3 reviewer, and vice versa.  We know this is a bit
different from how things work right now with regards to the
checkin-needed flag, so we're going to open a discussion on
mozilla.governance about this policy.

If one or more reviewers have left any issues, the icon will be the
number of open issues beside an exclamation mark on a yellow
backgroud. If that or any other reviewer has also left a ship-it (the
equivalent of an "r+ with minor issues"), the issue count will switch
to an r+ when all the issues have been marked as fixed or dropped.

If there are no open issues nor any ship-its, a grey r? will be
displayed.

We've also got some work in progress to make it clearer who has left what
kind of review that should be live in a week or two.

We also removed the ship-it button.  While convenient if you have
nothing else to say in your review, it's caused confusion for new
users, who don't understand the difference between the "Ship It!" and
"Review" buttons.  Instead, we now have just one button, labelled
"Finalize Review", that lets you leave general comments and, if
desired, a ship-it.  We plan on improving this dialog to make it
easier to use if you really just want to leave just a ship-it and no
other comments.

Finally, since our automation features will be growing, we moved the
Autoland-to-try button to a new Automation menu.

Where we're going
=================

As alluded to above, we're actively working on Autoland and trying to
land supporting features as they're ready.  We're aiming to have this
out in a few weeks; more posts to come.

Much of the rest of our plan for the next quarter or two is around
user experience.  For starters, MozReview *has* to support the same
feature set as Splinter/Bugzilla.  This means implementing things like
marking files as reviewed and passing your review onto someone else.
We also need to continue to improve the user interface by further
differentiating between parent review requests, which are intended only
to provide an overview of the whole commit series, and child review
requests, which is where the actual reviews should happen.
Particularly confusing is when there's only one child, which means the
parent and the child are nearly indistinguishable (of course in this
case the parent isn't really needed, but hiding or otherwise doing
away with the parent in this case could also be confusing).

And then we have some other big-ticket items like static analysis,
which we started a while back; release-management tools; enabling Review
Board's rich emails; partial-series landing (being able to land
earlier commits as they are reviewed without confusing MozReview in
the next push); and, of course, git support, which is going to be
tricky but will undoubtedly make a number of people happy.

Our priorities are currently documented on our new [road map][], which
we'll update at least once or twice a quarter.  In particular, we'll
be going over it again soon once we have the results from our
engineering-productivity survey.


[already blogged]: https://mrcote.info/blog/2015/08/04/mozreview-auth-changes/
[announced it]: https://groups.google.com/forum/#!topic/mozilla.dev.platform/9uJqecEBK0A
[on the command line]: https://bugzilla.mozilla.org/show_bug.cgi?id=1198087
[road map]: https://docs.google.com/document/d/1InULkB_8CaJ12pk5y_KqUJYEgoEQ15h-rfYEwKvL_8w/
[dminor's post]: http://www.lowleveldrone.com/mozilla/mozreview/2015/08/28/mozreview-workweek.html

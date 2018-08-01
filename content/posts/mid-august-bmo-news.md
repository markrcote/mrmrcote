---
title: "Mid-August BMO news"
date: 2013-08-15T12:12:00-04:00
categories: ["mozilla", "bmo"]
---
A lot of people probably don't know that I manage the [team][] behind 
[BMO][], that is, [bugzilla.mozilla.org][], Mozilla's Bugzilla
installation.  Work on BMO is continuous and incremental, and even really
useful features often take a while to percolate through the community, so I
thought I'd try to draw attention to some recent improvements that should
get you pumped to open a Bugzilla tab.

Suggested Reviewers
-------------------

A really exciting, and long-awaited, feature is suggested reviewers.  Now
when you flag a patch for review, you see a list of people who should make
good candidates.  And as of today, you can even see the number of reviews
in each person's queue!  There is a lot more in this feature, with even more
to come, so I'll just run down a list:

* The set of reviewers is per Product and per Component.  If there are
reviewers set for the particular Component, they are used; otherwise, it
defaults to that Product's reviewer set.
* The full set is available as a [report][] within Bugzilla.  Anyone with
"editcomponents" permission on a Product can change reviewers for that Product
or its Components.  Changes can also be requested by [filing a bug][] or
dropping by #bteam and talking directly to glob or dkl.
* The order of the suggested reviewers is identical to how it appears in the
report, which can be modified as above.
* Anyone with "away", "PTO", or "unavailable" in their "real name" field
will not be listed.
* Any bug that has a mentor set ([mentor=X] in the whiteboard) will
automatically have that user included in the suggested reviewers, at the
top, in bold, since presumably that person is best suited for this
particular bug.

Coming down the pipe is the ability to assign reviewers to subcategories of
a particular component, which will show up beside the reviewer's name in the
list.  Thus for components like Mochitest, you could indicate that a
reviewer is particularly suited to b2g-specific parts of the framework.  This
avoids having to create tonnes of smaller components just for reviewing
purposes.


Gravatars and the Sandstone Skin
--------------------------------

There is now an option to display Gravatars beside comment headers.  As with
any Gravatar-enabled site, the avatar is displayed if the commenter's
bugmail address has an associated Gravatar.  At the moment it is opt-in,
enabled from the [Preferences][] page (General Preferences / Show gravatar
images when viewing bugs), but when the Sandstone skin becomes the default,
Gravatars will be enabled for all users--but of course you can opt out if you
really don't like them.

Speaking of the Sandstone skin, some more improvements to it have landed
recently.  It's pretty slick, in my opinion, and will become the default
skin in a week or two when a couple remaining issues are resolved.  For now,
you can try it out by setting the General Preferences / Bugzilla's general
appearance (skin) option to Mozilla.  Of course, after it is made the default,
you can switch back to the old default (Dusk) if you prefer.


We have some more awesome changes landing in the next few weeks; I'll post
another summary then.

[team]: https://wiki.mozilla.org/BMO#Contributors.2FMaintainers
[BMO]: https://wiki.mozilla.org/BMO
[bugzilla.mozilla.org]: https://bugzilla.mozilla.org
[report]: https://bugzilla.mozilla.org/page.cgi?id=review_suggestions.html
[filing a bug]: https://bugzilla.mozilla.org/enter_bug.cgi?product=bugzilla.mozilla.org&component=Administration&format=__default__ 
[Preferences]: https://bugzilla.mozilla.org/userprefs.cgi

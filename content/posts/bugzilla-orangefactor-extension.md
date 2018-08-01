---
title: "Bugzilla OrangeFactor Extension"
date: 2012-09-22T13:48:00-04:00
categories: ["mozilla"]
---
Thanks to dkl, [bmo](https://bugzilla.mozilla.org) now has an extension
which shows a failure data for intermittent-orange bugs.  You'll have to
enable the extension by going to the [Preferences
page](https://bugzilla.mozilla.org/userprefs.cgi) and changing "When viewing
a bug, show its corresponding Orange Factor page" to "On".  Then the next
time you are viewing a bug about an intermittent orange, e.g.  the current
top orange, [bug 789003](https://bugzilla.mozilla.org/show_bug.cgi?id=789003),
at the bottom right of the metadata you should see a sparkline and a count
of the failures over the last week, plus a link to its [OrangeFactor page](https://brasstacks.mozilla.com/orangefactor/?display=Bug&bugid=789003).
Note that the sparkline corresponds to the failure count, not to the Orange
Factor (ratio of failures to test runs). If you think the latter would be more
useful, let me or dkl know&mdash;it's an easy change.

Bugs can be filed under [bugzilla.mozilla.org | Extensions: OrangeFactor](https://bugzilla.mozilla.org/enter_bug.cgi?product=bugzilla.mozilla.org&component=Extensions%3A%20OrangeFactor).

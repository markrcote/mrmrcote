---
title: "BMO's database takes a leap forward"
date: 2016-05-15T20:52:08-04:00
categories: ["mozilla", "bmo", "bugzilla"]
---
For historical reasons (or "hysterical raisins" as gps says) that
elude me, the BMO database has been in (ughhh) Pacific Time since it
was first created. This caused some weirdness on every daylight
savings time switch (particularly in the fall when 2:00-3:00 am
technically occurs twice), but not enough to justify the work in
fixing it (it's been this way for close to two decades, so that means
lots of implicit assumptions in the code).

However, we're planning to move BMO to AWS at some point, and their
standard db solution (RDS) only supports UTC. Thus we finally had the
excuse to do the work, and, after a bunch of planning, developing, and
reviewing, the migration happened yesterday without issues. I am
unreasonably excited by this and proud to have witnessed the
correction of this egregious violation of standard db principles 18
years after BMO was originally deployed.

Thanks to the BMO team and the DBAs!

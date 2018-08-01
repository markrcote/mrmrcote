---
title: "Rebasing Etiquette"
date: 2012-11-21T00:08:00-04:00
categories: ["mozilla", "git"]
---
I bet that the moment most people decide they actually *do* like git is when
they start using 'rebase' regularly.  I definitely do not completely
understand the git model, but rebase shows that there is some seriously
cool stuff going on.

Anyway, I've come upon a rebasing dilemma.  The reasons for not rebasing
a public repo are clear, but pushing to a remote origin (e.g. github) is
also a form of backup.  My master branches are for collaboration, but my
dev branches are essentially just to back up my home computer, and
occasionally for feedback.  I rebase dev branches regularly, to keep my
commits together for eventual merging to master.  I occasionally switch
around or squash commits too, where it adds clarity to the history.  So,
somewhat shamefully, I find myself using 'git push -f' a lot on branches
other than master.

I guess I could get a paid account and fork private dev repos, but branches
seem a lot more convenient, and I don't really want to hide anything from
anyone, as embarrasing as some of my work in progress sometimes seems to me.

Maybe the moral of this story is "never pull from my dev branches"?


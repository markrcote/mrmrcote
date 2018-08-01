---
title: "Moving Bugzilla from Bazaar to Git"
date: 2014-03-24T20:39:39-04:00
categories: ["mozilla", "bmo", "bugzilla"]
---
### Or, how to migrate to git using only three programming languages

Another aspect of Bugzilla has been dragged, kicking & screaming, into
the future! On March 11, 2014, the Bugzilla source
[moved to git.mozilla.org][]. We're still mirroring to
[bzr.mozilla.org][] (more on that later), but the repository of record
is  now git, meaning it is the only place we accept new code.

Getting over there was no small feat, so I want to record the
adventure in the hopes that it can benefit someone else, and so I can
look back some day and wonder why I put myself through these things.

## Background

The rationale isn't the focus of this post, but suffice it to say that
Bazaar isn't very widely used, and many projects are abandoning
it. Eric S. Raymond wrote a good [post on the Emacs dev list][] about
why they need to move from Bazaar to git. The same rationale applies
to Bugzilla: "Sticking to a moribund version-control system will
compound and exacerbate the project's difficulty in attracting new
talent."

So, moving on, I started off scouring the Internet to find the best
way to perform this migration. One major complication is the fact that
we want to keep mirroring (one-way) to Bazaar for at least a while, since
the main suggested way to [upgrade Bugzilla][] is from
bzr.mozilla.org. It was deemed unreasonable to require existing
installations to switch to git to obtain a small security fix, so
we'll continue to mirror changes to Bazaar for some time.


## Initial migration

I found a few posts here and there about people who had done
migrations like this, but the most useful was [a post by David Roth][]
from last year that detailed how to preserve Bazaar's commit metadata,
specifically bug-tracker metadata, which Bugzilla has used on
virtually every commit since [switching from CVS][]. It involves using
the `--no-plain` option with `bzr fast-export` and then translating
the output to something git understands.

Interestingly, Roth's translation script was written in C#, not my
personal first choice for such a task (or any, really, since I don't
generally develop for Windows). However it compiled fine under
[Mono][], so I could run it on a Linux box. Something I learned,
though, is to *not* try this kind of thing on OS X, where, by default,
the filesystem is case-insensitive.

As much as I'd prefer to deal with a
[language with which I am more comfortable][], I dislike duplicated
effort even more. I used Roth's
C# script as a basis, modifying it a bit for our needs. The metadata
is in the form `<bug URL> <resolution>`. Rather than editing existing
commit messages, I just took that string and pasted it to the bottom
of the commit message, but only if the bug number was not already in
the commit message. This actually revealed a few typos in the "Bug
123456" strings that generally start commit messages.

There turned out to a few other subtle bugs, like the fact that a file
which is both renamed and modified in the same commit shows up, in the
output from `bzr fast-export`, as being modified under the original
name. Thus if the delete is processed first, it looks like bzr has
modified an nonexistent file. Those were easy to see by comparing the
contents of every file before and after migration (admittedly just for
the last revision).

Since there are a lot of branches on bzr.mozilla.org, I created a bash
script to record them all and make sure none were missed. It output
the pre-/postmigration diff of md5 sums as well as doing a
[git repack][] for each repo, after all branches were migrated.

One thing I forgot was pushing tags via the `--tags` option to `git push`;
I had to do that manually after the migration. That's also when I
discovered that the same tag existed in several related bzr branches
which were all combined into one git repo. This is, of course, not
allowed in git. It made me think more about how Bugzilla uses certain
tags, like `current-stable`, which are moved after each release. In
git this requires the `--force` option to `git push` and is a big
no-no if the remote repo is shared. I learned that, in fact, this is
also the case in bzr, though perhaps it's regarded as less of a sin
than it is in git. Anyway, I've since realized that those should be
branches, named appropriately (per branch). Despite them not being
branches in the standard sense&mdash;they'll always point to somewhere at or behind a
version branch and never fork&mdash;it's perfectly acceptable to move them,
as opposed to tags, and since they'll always be fast-forwarded, they
won't take any more space than a lightweight tag.

## Mirroring

This was a harder problem. Originally, I tried to use the
[bzr-git extension][], and it failed when I tried to pull in changes from
git. I exchanged some emails with bzr-git's author, Jelmer Vernooij,
and he said that to keep an existing bzr branch in sync with a newly
formed git repo is impossible at the moment: "This is essentially the
'roundtripping' support that we've been trying to achieve with bzr-git
for a while. It's a nontrivial problem (since it requires all
semantics from bzr to be preserved when pushing to git)." Considering
bzr-git hasn't had a new release in two years, I won't be holding my
breath.

Luckily (and perhaps somewhat unfortunately) Bugzilla has jumped VCSes
before, as I hinted above. With the old [bzr-to-cvs][] script as a
starting point, I created a git-to-bzr script&mdash;in, of course, Perl, as
the original.

This script is essentially an automated way of applying individual
commits from a git branch to a bzr branch. For each commit, the entire
file tree is copied from a local git clone to a local bzr checkout,
`bzr add` and `remove` are executed where needed, and the changes
committed with the original author, contributor, and date
preserved. The script also parses out the standard "Bug X:"
commit-message format and passes it to bzr's `--fixes` commit
option. A file called `.gitrev` in the bzr repo tracks the associated
git commit ID for each bzr commit.

To avoid excessive disk activity, since the script polls git and bzr
for changes, the script uses `bzr cat` to check the contents of the
`.gitrev` file and `git ls-remote` to get the ID of the last git
commit. If they are equal, no further actions are performed.

## Summing up

And that, folks, is how you can migrate from bzr to git! The initial
migration is pretty straightforward, more so if you don't care about
any bzr commit metadata. It was unfortunate that there was no
off-the-shelf way to sync the repos afterwards, but the basic idea
isn't too complicated.

For more, there's the [project page][] on our wiki, and all the
scripts used are in a [GitHub repo][] for your perusal. I'm no VCS
expert&mdash;I've never heavily used bzr, and I'm constantly learning
new things about git&mdash;but feel free to ask me questions if you
want our process further clarified.

[moved to git.mozilla.org]: http://git.mozilla.org/?p=bugzilla/bugzilla.git;a=summary
[bzr.mozilla.org]: http://bzr.mozilla.org
[post on the Emacs dev list]: http://lists.gnu.org/archive/html/emacs-devel/2014-01/msg00005.html
[upgrade Bugzilla]: http://bugzilla.readthedocs.org/en/latest/installation.html#getting-the-new-bugzilla
[a post by David Roth]: http://www.fusonic.net/en/blog/2013/03/26/migrating-from-bazaar-to-git/
[switching from CVS]: https://bugzilla.mozilla.org/show_bug.cgi?id=470570
[Mono]: http://www.mono-project.com/Main_Page
[language with which I am more comfortable]: https://www.python.org
[git repack]: http://metalinguist.wordpress.com/2007/12/06/the-woes-of-git-gc-aggressive-and-how-git-deltas-work/
[bzr-git extension]: https://launchpad.net/bzr-git
[bzr-to-cvs]: http://bzr.mozilla.org/bzr-plugins/bzr-to-cvs/files
[project page]: https://wiki.mozilla.org/Bugzilla:Migrating_to_git
[GitHub repo]: https://github.com/markrcote/bugzilla-git-migration

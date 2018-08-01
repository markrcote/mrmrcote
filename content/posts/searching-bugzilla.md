---
title: "Searching Bugzilla"
date: 2014-12-17T10:37:42-05:00
categories: ["bugzilla", "bmo", "mozilla"]
---
[BMO][] currently supports five—count 'em, five—ways to search for
bugs.  Whenever you have five different ways to perform a similar
function, you can be pretty sure the core problem is not well
understood.  Search has been rated, for good reason, one of the least
compelling features of Bugzilla, so the BMO team want to dig in there
and make some serious improvements.

At our Portland get-together a couple weeks ago, we talked about
putting together a vision for BMO. It's a tough problem, since BMO is
used for so many different things. We did, however, manage to get some
clarity around search. [Gerv][], who has been involved in the Bugzilla
project for quite some time, neatly summarized the use cases. People
search Bugzilla for only two reasons:

* to find a set of bugs, or
* to find a specific bug.

That's it.  The fact that BMO has five different searches, though,
means either we didn't know that, or we just couldn't find a good way
to do one, or the other, or both.

We've got the functionality of the first use case down pretty well,
via Advanced Search: it helps you assemble a set of criteria of almost
limitless specificity that will result in a list of bugs. It can be
used to determine what bugs are blocking a particular release, what
bugs a particular person has assigned to them, or what bugs in a
particular Product have been fixed recently. Its interface is,
admittedly, not great. Quick Search was developed as a different,
text-based approach to Advanced Search; it can be quicker to use but
definitely isn't any more intuitive. Regardless, Advanced Search
fulfills its role fairly well.

The second use of Search is how you'd answer the question, "what was
that bug I was looking at a couple weeks ago?"  You have some hazy
recollection of a bug.  You have a good idea of a few words in the
summary, although you might be slightly off, and you might know the
Product or the Assignee, but probably not much else.  Advanced Search
will give you a huge, useless result set, but you really just want one
specific bug.

This kind of search isn't easy; it needs some intelligence, like
natural-language processing, in order to give useful
results. Bugzilla's solutions are the Instant and Simple searches,
which eschew the standard Bugzilla::Search module that powers Advanced
and Quick searches. Instead, they do full-text searches on the Summary
field (and optionally in Comments as well, which is super slow). The
results still aren't very good, so BMO developers tried outsourcing
the feature by adding a Google Search option. But despite Google being
a great search engine for the web, it doesn't know enough about BMO
data to be much more useful, and it doesn't know about new nor
confidential bugs at all.

Since Bugzilla's search engines were originally written, however,
there have been many advances in the field, especially in FLOSS. This
is another place where we need to bring Bugzilla into the modern
world; MySQL full-text searches are just not good enough. In the
upcoming year, we're going to look into new approaches to search, such
as running different databases in tandem to exploit their particular
abilities. We plan to start with experiments using [Elasticsearch][],
which, as the name implies, is very good at searching. By standing up
an instance beside the main MySQL db and mirroring bug data over, we
can refer specific-bug searches to it; even though we'll then have to
filter based on standard bug-visibility rules, we should have a net
win in search times, especially when searching comments.

In sum, Mozilla developers, we understand your tribulations with
Bugzilla search, and we're on it. After all, we all have a reputation
to maintain as the [Godzilla of Search Engines][]!

[BMO]: https://bugzilla.mozilla.org
[Advanced Search]: https://bugzilla.mozilla.org/query.cgi?query_format=advanced
[Gerv]: http://gerv.net
[Elasticsearch]: http://www.elasticsearch.org/
[Godzilla of Search Engines]: http://image.slidesharecdn.com/2011-07mosc-110706015504-phpapp02/95/2011-07-malaysia-open-source-conference-7-728.jpg?cb=1309935582

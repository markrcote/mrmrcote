---
title: "MozReview auth changes"
date: 2015-08-04T13:18:42-04:00
categories: ["mozilla", "bmo", "mozreview"]
---
MozReview will soon be using Bugzilla's new OAuth-like<sup>1</sup>
API keys and auth delegation.  This is long overdue, and, in addition to
providing security benefits, will eliminate all those confusing
session-expired errors (e.g. [bug 1178814][]).

After we deploy the change, all users will need to log back into
MozReview's Review Board<sup>2</sup> instance.  This time, rather than entering
your Bugzilla credentials directly into Review Board, when you go to
the "Log In" page, you'll be redirected to BMO.  If you don't have a
current BMO session, you'll have to log into BMO.  After you log in,
or immediately after being redirected to BMO if you do have a session,
you'll be redirected back to Review Board and logged in.  This is
because, unlike most third-party apps, MozReview's Review Board is a
trusted app that is tightly integrated to BMO, so you won't be
confronted with the standard "Auth Delegation Request" intermediate
page.

This is the first stage of conversion to API keys.  For pushing review
requests with Mercurial, you will still have to have either your
Bugzilla username and password or your cookies in your .hgrc file or enter
them on the command line at push time.  However, Review Board will no
longer store cookies; the username/password or login cookies will only
be passed to BMO for verification and then discarded.  We'll be moving
to API key usage on the command line in a subsequent patch.

Through API keys, Review Board will only have access to the specific BMO APIs
required by MozReview.  Those actions are mainly restricted to
creating and updating attachments and posting comments; however, it
will also need access to the login API until we support API keys on
the command line.  As noted, this will be used solely for
identification, and no login tokens will be stored in MozReview.

Another big benefit of API keys is the elimination of those annoying
and confusing expired-session errors.  The BMO cookies used by
MozReview have a limited lifespan, but API keys are good until
explicitly revoked by the user.  You can see the API key that is
transferred to MozReview, as well as any other API keys you've
manually or automatically created, in the [API Keys tab][] in your BMO
preferences.  Revoking the API key won't automatically log you out of
Review Board, but you won't be able to do any actions that interact
with BMO (most actions) unless you log out and back in again (thus
generating a new key).

You can follow along progress in [bug 993233][].

***

1. No, it's not exactly OAuth, but it's based on similar ideas.
We haven't found a good OAuth 2 library for use with BMO, but we're looking
around.

2. A note about names: MozReview generally refers to the full
code-review system, which is primarily an hg server and a Review Board
installation with extensions that we've developed.  It also includes
BMO, Autoland, Pulse, LDAP, and little things like code-review bots.
When we say "Review Board", we are referring specifically to the web
app, which is the primary user interface to MozReview.

[bug 1178814]: https://bugzilla.mozilla.org/show_bug.cgi?id=1178814
[API Keys tab]: https://bugzilla.mozilla.org/userprefs.cgi?tab=apikey
[bug 993233]: https://bugzilla.mozilla.org/show_bug.cgi?id=993233

---
title: "Bugzfeed: Bugzilla push notifications"
date: 2014-04-04T00:13:30-04:00
categories: ["mozilla", "bmo", "bugzilla"]
---
A large number of external applications have grown up around Bugzilla
serving a variety of purposes.  One thing many of these apps have in
common is a need to get updates from Bugzilla.  Unfortunately, the
only way to get notifications of changes was, until recently, to poll
Bugzilla.  Everyone knows that polling is bad, particularly because it
doesn't scale well, but until recently there was no alternative.

Thus I would like to introduce to the world [Bugzfeed][], a
[WebSocket][] app that allows you to subscribe to one or more bugs and
get pushed notifications when they change.  It's rather a small app,
based on [Tornado][], and has a very simple interface, so it should
scale quite nicely.  It relies on a few moving parts to work, but I'll
start with the basics and explain the whole system later.

The production version is at ws://bugzfeed.mozilla.org.  I also made a
very simple (and ugly) [example app][] for you to use and examine.  A
development version of Bugzfeed is available at
ws://bugzfeed-dev.allizom.org; it's tied to the
[development Bugzilla server][], so it's a good place to experiment if
you're a Mozilla contributor; you can make whatever changes you need
to bugzilla-dev without worrying about messing with production data.
You'll need to get someone in #bmo on irc.mozilla.org to reset your
password, since we periodically refresh and sanitize the database on
bugzilla-dev, and email is disabled so you can't reset it yourself.

(This makes me think that there should probably be a Bugzfeed instance
tied to [Landfill][]; maybe I'll look into that, in particular if we
implement middleware other than Pulse (see below).)

Client commands, responses, and notifications are all in JSON format.
The [project wiki page][] has the full list of [commands][].  Here's a
little example of what you need to send to subscribe to bugs 1234 and
5678:

    {"command": "subscribe", "bugs": [1234, 5678]}

The server will send a simple response, including a list of all the
bugs you are (now) subscribed to:

    {"command": "subscribe", "result": "ok", "bugs": [1234, 5678]}

Now you can just wait for notifications to be pushed from the server
to your app:

    {"command": "update", "bug": 1234, "when": "2014-04-03T21:13:45"}

Wait, you are probably asking, that's it?  That's all I get?

The short answer is yup, that's it.  You can now use the regular
[REST API][] to get further details about what changed.

The longer answer is yup, that's it, because security.  Bugzilla has
evolved a very fine-grained security system.  We have bugs,
attachments, and even comments that can only be seen by a privileged
few, due to security, legal, and other considerations.  Furthermore,
many of the variables involved in determining whether a particular
user can see a particular bug/attachment/comment can change at any
time: not only can elements of a bug shift between public and
confidential, but so can a user's groups, and the groups themselves.
Monitoring for all those possible changes would make this app
significantly more complex and brittle, so we opted for the most
secure notification, which is also the simplest: just a bug ID and a
timestamp.  All the other work is handled by the standard Bugzilla
APIs.

(You might also be asking "why is 'update' considered a command?" and,
to be honest, I'm not sure, so maybe that'll change.)

There are other commands, and some limited caching of changes in case
your client disconnects; see the [project wiki page][] for more.

* * *

So how does it work?  Here's a system diagram created by contributor
musingmario:

![Bugzfeed system diagram](https://wiki.mozilla.org/images/b/b8/BMO_-_Change_Notification_System_v0.4.PNG)

The four main pieces (with links to source) are

* [ZPushNotify][], the Bugzilla extension.

* [bugzilla\_simple\_shim][shim], a Python app that consumes from the Bugzilla
  extension and publishes to Pulse.

* [Pulse][], a [RabbitMQ][] server (with a [supporting Python package]).

* [Bugzfeed][], the WebSocket server.

On the Bugzilla side, the [BMO][] team created an extension which writes
the bug ID and timestamp to a table when any bug changes.  A simple
Python app polls this table and sends all the updates to Pulse,
cleaning up the table as it does so.

Pulse is a Mozilla RabbitMQ server with a specific configuration and
message format implementing the [publish/subscribe][] pattern.  The
usage is somewhat Mozilla specific, but it would be pretty easy to set
up a similar system or even modify Bugzfeed and the Bugzilla shim to
use RabbitMQ directly, or a different [AMQP][] system like [&Oslash;MQ][ZeroMQ].

Notifications from all bugs flow through Pulse; it is Bugzfeed, the
WebSocket server, that does the filtering for its clients to notify
only on subscribed bugs.  Subscribing to individual notifications from
Pulse is possible via [topics][], but this requires one channel per
bug, so I doubt it would be any more efficient if hundreds of clients
are connected to Bugzfeed.

While you could have the Bugzfeed server read directly from the
Bugzilla database, eliminating the shim and the queuing system, having
an intermediary allows us to easily stand up more Bugzfeed servers if
load gets too high, as each Bugzfeed instance would see the stream of
changes via its own subscriber queue.  We can also easily interface
new applications to the notification stream, such as the
[BMO Elastic Search cluster][].

Enough technicalities; go out and play with it!  And if you want to
adapt it for your own Bugzilla installation, I'd be more than willing
to help out.

[Bugzfeed]: https://github.com/mozilla/bugzfeed
[WebSocket]: https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
[Tornado]: http://tornadoweb.org/
[example app]: http://people.mozilla.com/~mcote/bugzfeed_example/
[development Bugzilla server]: https://bugzilla-dev.allizom.org/
[Landfill]: https://landfill.bugzilla.org/
[project wiki page]: https://wiki.mozilla.org/BMO/ChangeNotificationSystem
[commands]: https://wiki.mozilla.org/BMO/ChangeNotificationSystem#Commands
[REST API]: http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Server/REST.html
[ZPushNotify]: http://git.mozilla.org/?p=webtools/bmo/bugzilla.git;a=tree;f=extensions/ZPushNotify
[shim]: https://hg.mozilla.org/automation/pulseshims/file/tip/
[Pulse]: https://wiki.mozilla.org/Auto-tools/Projects/Pulse
[RabbitMQ]: http://www.rabbitmq.com/
[supporting Python package]: https://pypi.python.org/pypi/MozillaPulse
[BMO]: https://wiki.mozilla.org/BMO
[publish/subscribe]: http://www.rabbitmq.com/tutorials/tutorial-three-python.html
[AMQP]: http://www.amqp.org/
[ZeroMQ]: http://zeromq.org/
[topics]: http://www.rabbitmq.com/tutorials/tutorial-five-python.html
[BMO Elastic Search cluster]: https://wiki.mozilla.org/BMO/ElasticSearch

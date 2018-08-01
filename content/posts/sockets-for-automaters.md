---
draft: true
title: "sockets for automaters"
date: 2012-10-22T00:49:00-04:00
categories: ["mozilla", "networks", "programming"]
---
Automation (and its related field of tools development) is a really varied
field. We do systems-level programming, web apps, manage remote devices,
calculate statistics, and a whole bunch of other stuff. It's no wonder, then,
that most automation developers are generalists. We have a wide range of
experience, but we don't often have really in-depth knowledge in very many
fields.

Sooner or later, many automation developers will need to do some network
programming. Python, which we tend to use because of how quickly we can
bring an app up and, if written well, how intelligible it remains over time,
makes socket code pretty easy to write. So easy, in fact, that you can fool
yourself into thinking you've done it right when what you have is a shaky
app that can fall over in any of the bazillions of ways that a network--or a
device on the network--can fail.

I've done socket programming on and off for years, so I thought I'd present
some of the knowledge I think would be helpful to a developer about to
embark on a network app.  Even though my target audience is automation
developers, really any coder who isn't already specialized in networks might
be able to learn something here.

I'm going to split my this into three other posts, organized by theme:

* socket basics
* error handling and recovery
* protocol design

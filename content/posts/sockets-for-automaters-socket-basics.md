---
draft: true
title: "sockets for automaters: socket basics"
date: 2012-10-23T15:35:00-04:00
categories: ["mozilla"]
---
Python has a few modules that abstract away a lot of the underlying socket
calls, including SocketServer and asyncore. These are designed with certain
assumptions in mind; when those assumptions are correct, the task is made very
easy, but it quickly becomes difficult and confusing to shoehorn in changes
when the fundamental assumptions are different. For example, asyncore expects
every command to have a separate connection, which can be inefficient and
breaks any notion of session state.

Once you've decided that you need to write lower-level socket code, you have a
few decisions to make immediately. The first is what protocol to use, which is
generally TCP vs UDP. TCP should be your default choice for simple command
protocols; UDP has more specialized uses when you don't need or want TCP's
features like built-in error checking. As I'll discuss in the next post, even
though all automation requires robust error checking and handling, resist the
urge to duplicate what TCP is already doing, such as check-summing data.

The next decision is whether to use blocking or nonblocking sockets. This 
decision will affect the architecture of your program, so be sure to make it
consciously and immediately. Your decision will rest in part on whether you
are writing a client or a server.

For simple client programs and modules, the obvious choice is nonblocking
sockets, since generally you won't have to worry about maintaining several
connections, and thus it won't cause any problems if your program blocks for a
while. However, note that recv() calls on blocking sockets *never* return
unless there is data available, or a few other exceptional circumstances like
dropped connections or KeyboardInterrupts. This means you can't implement
timeouts; you have to rely entirely on TCP for this, which generally has quite
a long timeout period. This makes error detection a fair bit harder, especially
if you have flaky hardware or software on the server side. More on this in the
next post.

For servers, your choice of nonblocking vs. blocking generally rests on how
you want to handle concurrency.  Blocking sockets, or simple nonblocking
sockets that just handle timeouts, require multiple threads or processes.  It
is impossible to overstate how simple threads can first appear and how many
problems they can cause down the line.  Reactor-style patterns that use
select or poll system calls can be confusing at first, especially since they
invert the flow of a typical program, but they are often a lot easier to debug
once the central event-dispatching system is implemented.  A longer discussion
is out of scope of this post, however.

It's my recommendation to use nonblocking sockets all the time, even if you
are dealing with a relatively simple flow, just because they provide more
options for error handling, as I mentioned above.  You'll want to call
settimeout() on the socket with an appropriate value right after creating it.



- sockets
-- learn blocking vs nonblocking
-- in general, blocking okay for simple clients
-- learn when to stop reading
--- return None, EAGAIN
--- settimeout vs select
-- buffering
-- handle timeouts
-- handle errors - make sure to pause in retry loop since error might be immediate
 - log socket error messages/types
-- fatal vs transient
-- retry, back off timer
-- error handling -- just disconnect
-- use exceptions for errors -- differentiate functions that do something vs
   query something
-- platform independent
--- posixpath vs os.path
-- logging
--- ultra verbose level
--- recognizable error prefixes (?)
-- don't try to do too much - exec and such
-- don't overdo things


- learn how to use sockets
-- socketserver nice but limited -- each request is a connection
-- asyncore doesn't have fine-tuned level of control
-- blocking vs nonblocking
-- how to determine when data is available vs when the connection has closed
-- remember to buffer if you are looking for a delimiter
--- socketserver file-like stream?

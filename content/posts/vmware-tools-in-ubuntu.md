---
title: "VMware Tools in Ubuntu"
date: 2013-11-28T11:22:15-05:00
categories: ["mozilla"]
---
I went about the seemingly simple task of sharing a directory in OS X
with an Ubuntu VMware box so that I could code in my main desktop and
run under Linux.  The simple sharing dialog is of course only the
beginning of the work; after that, I needed to refresh VMware tools,
since I had done several kernel upgrades.  Well that turned into a few
hours of flailing at a command line.

For whatever reason, the kernel headers aren't automatically found by
the VMware Tools installation program, and even when you give the
direct path, it still denies that they exist.  Some web trawling told
me that it looks for version.h, which isn't in the root header
directory, so I made a symlink.  Then the installer found it but got
compiler warnings a short time later.

I'm writing this post to tell you not to bother with any of that.
Installing the open-vm-tools package from the multiverse repository is
actually all you need!  It's amazing how many different searches it
took for me to finally figure that out.  I had to unshare and the
reshare my directory for it to finally work, but now it's working
great.  Let's see what happens the next time I upgrade my kernel
though...

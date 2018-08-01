---
title: "Autophone, a case study in automating that which does not want to be automated (part 1)"
date: 2013-06-07T01:53:00-04:00
categories: ["mozilla", "autophone"]
---
[Autophone](https://wiki.mozilla.org/Auto-tools/Projects/AutoPhone) is an
automated system that executes Python test scripts on real
user hardware, that is, actual phones. It's been an active project for about
a year now, and we've learned a lot about the difficulties
of performing automated performance measurements on hardware that was never
intended for automation. I'm documenting this story for posterity, since it
has been an interesting, if often frustrating, experience. If you want to
follow along, the source is [on github](https://github.com/mozilla/autophone/).

I'm going to divide this into a few posts to hopefully avoid tl;driness and to
ensure I actually finish at least some of this.

Background
----------

For correctness testing, Mozilla's Fennec automation is largely done with
development boards, specifically Tegras and Pandas. These boards have
wired power and ethernet, perfect for rack mounting, and all of a given
type generally behave the same.

These boards are not, of course, consumer devices, and,
despite having similar chipsets as real phones, they have different
performance characteristics. To really see how Fennec performs in the real
world, we need to measure Fennec on devices that people are buying and using every day. Thus
was born the Autophone project.

Devices
-------

At the moment, the existing Autophone production system runs tests on kind-of-to-very "old" phones. This isn't a limitation of Autophone; rather, it's a
sampling of phones that were still very common last year, when the project
got truly underway. We will add newer phones as time progresses, especially
now that the system is very stable. The current system has at least one of
the following phones:

* HTC Google Nexus One
* LG Revolution
* Motorola Droid Pro
* Samsung Galaxy SII
* Samsung Galaxy SIII
* Samsung Google Nexus S

We have a few more phones waiting to be deployed in a second cluster.

Architecture
------------

A brief discussion of Autophone's design may help in  understanding the
problems in automation and performance measurements by providing some context.

Autophone consists of a main Python process with one worker process per phone.
We used processes instead of threads to isolate certain failures from other
workers. The main process has separate threads for its TCP command
server and for a [pulse](http://pulse.mozilla.org) listener.

The worker processes are each tied to a single device and are responsible
for controlling that device. The devices all have the [SUTAgent](https://wiki.mozilla.org/Auto-tools/Projects/SUTAgent) and Watcher
installed, to which the processes talk via [mozdevice](https://mozbase.readthedocs.org/en/latest/mozdevice.html). A worker is spawned
when the main process receives a [SUT registration](https://wiki.mozilla.org/Auto-tools/Projects/SUTAgent#Registration_Server) message on its command
port from an unknown device. Device info is cached in a JSON file, and
workers are also launched upon startup for any known device.

The workers each listen to their own queue, which receives commands from the
main process. Commands come from users, via the command server, or are
triggered by a build notification from pulse. The workers also check for
jobs every 10 seconds (see below).

Autophone also includes a simple build cache server. This server handles
requests for builds from the workers, fetching them via ftp as necessary,
ensuring that only one copy of a particular build is downloaded at the same
time, and that recently used builds are kept around, subject to space
restrictions. (This part is actually very common to our automation frameworks,
so it really should be extracted and put into its own module. Even better would
be to extend [mozdownload](https://github.com/mozilla/mozdownload/) to support Fennec and have the build cache server
use that to fetch builds. But I digress.)

Tests
-----

When a build notification is received from pulse, or when a user issues
a "triggerjobs" command, for each device an entry containing the build URL and device name is inserted into a sqlite database. A generic "job"
command is then issued to each worker. As mentioned above, the workers
poll this database every 10 seconds. They also poll the database immediately after
executing a command, so the "job" command serves merely to trigger a poll of the database. This mechanism allows for worker processes
to be restarted, since even if a "job" command is missed, the job itself
will be picked up from the database. Along a similar vein, if the whole
system is shut down, the current test will be restarted, and any queued
tests will remain.

When a job successfully completes, the associated entry for that device and
build is deleted from the jobs database. The number of attempts for each job is also recorded, and a job is abandoned after too many attempts, in case there are
unrecoverable problems with a particular build or build/device combination.

Tests themselves are Python classes specified in a [ManifestDestiny](https://mozbase.readthedocs.org/en/latest/manifestdestiny.html#manifestdestiny-create-and-manage-test-manifests) manifest
file. They are (for better or for worse) executed in the worker process,
i.e., not as a (further) separate process. Test classes are derived from a base
class, PhoneTest, and are pretty much free form, requiring only a runjob()
method that takes a dict of build metadata and the worker subprocess object,
which can be used to manipulate the device as necessary, in particular to
attempt to recover a frozen/disappeared device (though this part should probably be
split into its own object, since a test shouldn't be messing with the worker process
object). The PhoneTest base class also provides some
convenience functions to push profiles, start fennec, and report status
messages to the main process.

At the moment, we have a single active test, S1S2, which measures Fennec
startup performance. We also have support
for a few unit tests (crashtests, reftests, JS reftests, mochitests, and
robocop), though these are currently disabled pending some stability fixes.

Next post I'll discuss the goal of S1S2, its challenges, and our solutions.


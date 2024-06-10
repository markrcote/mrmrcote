---
title: "How to get started with Learn to Program With Minecraft in 2024"
date: 2024-06-10T11:54:15-04:00
draft: true
---

I acquired a copy of [_Learn to Program with
Minecraft_](https://nostarch.com/programwithminecraft) from [No Starch
Press](https://nostarch.com/) a while ago but only recently decided to crack it
open.  Multiple versions of Minecraft, Spigot, and Python have been release
since, but the provided zip file on the publisher's website hasn't been kept up
to date.  I took some time to figure out how to replicate the setup and figured
I'd write it down for posterity.  These instructions are for Windows 11.

First, as the book notes, you need Minecraft Java Edition.  This is easy to
install via the Minecraft Launcher, which you can get from the Windows Store.  I
have version 1.20.6 installed.

Python is also easily installed these days via the Windows Store.  I grabbed
version 3.12.  You will also need to install the `mcpi` Python package.  The
best practice is generally to install non-system Python packages via
`virtualenv` or a similar tool to keep them isolated, but given this is a
programming book for kids, it's easier to just install it globally (well, for
your specific user) via `pip install mcpi`.

You'll need Java 21 (the JDK specifically). The official Spigot docs recommend
installing the [Azul Zulu
JDK](https://www.azul.com/downloads/?version=java-21-lts&package=jdk#zulu).

Spigot, the modified Minecraft server, has to be installed via a separate
program, BuildTools, due to [DMCA
concerns](https://github.com/github/dmca/blob/master/2014/2014-09-05-CraftBukkit.md).
Create a directory for the BuildTools installation, e.g.
`Downloads/BuildTools`.  Download the GUI version of BuildTools from the top of
the [BuildTools docs](https://www.spigotmc.org/wiki/buildtools/) and save it
into the newly created directory, then run it. This'll take a while.  You'll end
up with a Spigot installation in that directory.

You'll also need the RaspberryJuice plugin for Spigot.  This tripped me up for a
bit, as I didn't notice at first that it was packaged up with the zip file for
the book. RaspberryJuice provides an API based on the old [Minecraft Pi
Edition](https://minecraft.fandom.com/wiki/Pi_Edition).  You can get it from
[bukkit.org](https://dev.bukkit.org/projects/raspberryjuice); the link is under
Recent Files on the right side of the page.

RaspberryJuice hasn't been updated since 2017, and it'll trigger a legacy-plugin
warning in Spigot.  From what I can tell, though, everything seems to work fine
(note that I haven't actually gone through the entire book yet).

The zip file for the book also includes the
[SetSpawn](https://dev.bukkit.org/projects/setspawn) Spigot plugin, but it no
longer seems to work and hasn't been updated in 3 years.  I have't seen in the
book yet where it is used, though, so I haven't bothered trying out an
alternative.

You'll need to indicate acceptance of the EULA by just writing `eula=true` in a
file named `eula.txt` in the directory you created (which now has the Spigot
installation).  You can also start Spigot (see below), which will create that
file automatically but with `eula=false`.  It'll then complain abou the EULA not
be accepted and exit.  You can then edit `eula.txt`, change the value to `true`,
and run Spigot again.

Open `server.properties` and change `gamemode=survival` to `gamemode=creative`
to match the default in the book's zip file.

Next you can start up Spigot.  I am not sure what the optimal Java config is (it
seems to be a complicated topic, particularly for someone who hasn't done a lot
of Java programming), so I just threw 2 gigs of RAM at it.  You can run it from
the command prompt or PowerShell like so:

```
java -Xms2048M -Xmx2048M -jar spigot-1.20.6.jar
```

You can also put this in a file called `start.bat` alongside the `jar` file and
just run that instead.

You'll probably get a firewall warning; accept that (generally you'll want to
only allow access for private networks).

That's it!  With Spigot running, you should be able to run the following with no errors in IDLE or in the Python interpreter via the Command Prompt/PowerShell:

```
from mcpi.minecraft import Minecraft
mc = Minecraft.create()
```

If the second line generates an error, it's likely due to Spigot not running,
the RaspberryJuice plugin not being installed, or (perhaps) a firewall rule.

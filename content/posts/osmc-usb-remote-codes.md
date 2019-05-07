---
title: "OSMC USB Remote Codes"
date: 2019-05-06T21:56:43-04:00
---

The last Raspberry Pi that I bought (the one that powers my
[ledweb](/blog/2018/05/16/ledweb/) setup) came with a remote control intended
for media servers, one of the
[official OSMC remotes](https://osmc.tv/store/product/osmc-remote-control/).
I thought it would be fun to use it to do something involving my LED panel, like
switching between different modes or something.

I couldn't find any information on using this remote outside of OSMC, however.
I've never done any programming that interfaced directly with a USB device
either.  But it turned out to be surprisingly straightforward.

After figuring out which USB device it was (by running `lsusb`, unplugging the
receiver, and running it again, naturally), I did some very minimal reading
about USB, enough to understand that devices can have multiple interfaces.  I
then took a closer look via `lsusb -v`.  Turns out that it has two interfaces,
one using the mouse protocol and one using the keyboard protocol (I'm not sure
why the first is recognized as a mouse, though, since all the buttons map to
keys...).  A bit more Googling (er, DuckDuckGoing) informed me such devices are
exposed via `/dev/input/event?` device files.  And a little bit more searching
revealed the `evdev` Python package that reads from these devices.  A simple
script taken from a
[Stack Overflow answer](https://stackoverflow.com/a/37137943/1575211) and I was
able to categorize the different buttons.

It turns out that _both_ input devices are actually used by the remote, for
different keys.  On my machine, `/dev/input/event0` reads from the directional
controls: the arrows (unsurprisingly) map to `KEY_UP`, `KEY_RIGHT`, `KEY_DOWN`,
and `KEY_LEFT`.  The "OK" button in the middle maps to `KEY_ENTER`.  The home
button on the top left also uses this device, mapping to `KEY_HOME`.  The other
keys can be read from `/dev/input/event1`.  The "i" button on top right maps to
`KEY_INFO`.  THe other six buttons map as follows (left to right, top to
bottom): `KEY_BACK`, `KEY_CONTEXT_MENU`, `KEY_PLAYPAUSE`, `KEY_STOP`,
`KEY_REWIND`, and `KEY_FASTFORWARD`.

Now to actually make them do something interesting!

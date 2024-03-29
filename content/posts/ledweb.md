---
title: "ledweb"
date: 2018-05-16T21:18:29-04:00
categories: ["personal", "hobbies"]
---
Having taken advantage of a Black Friday sale at [BuyaPi.ca][] and
picked up a [Raspberry Pi 3 Model B][], I then needed something to do
with it. I'm not sure how it popped into my head, but at some point I
realized my bar absolutely needed a [Times Square zipper][]-type LED
display. I mean, it seems so obvious in retrospect.

At first I thought about [making one][] but then I thought "hahah yeah
right no". Luckily Adafruit caters to people of a similar mindset, so
I got myself a superfancy [64x32 RGB LED matrix][]. The [assembly][]
tested my very rusty soldering skills (and also made me realize how
my near vision has degraded in the past ten years...), but it powered
up just fine!

<blockquote class="twitter-tweet" data-lang="en"><p lang="en"
dir="ltr">Yisssss why did I doubt my soldering skills <a
href="https://twitter.com/hashtag/RaspberryPi?src=hash&amp;ref_src=twsrc%5Etfw">#RaspberryPi</a>
<a
href="https://t.co/tygsDGukz3">pic.twitter.com/tygsDGukz3</a></p>&mdash;
Mark Côté (@markrcote) <a
href="https://twitter.com/markrcote/status/938968754964324352?ref_src=twsrc%5Etfw">December
8, 2017</a></blockquote> <script async
src="https://platform.twitter.com/widgets.js"
charset="utf-8"></script>

After that, I thought it would be a neat trick to let visitors draw on
the matrix. Of course I don't know who would actually bother doing
that, at least more than once, but I think it would sound cool to
mention at a party. [Jenn Schiffer][]'s awesome [Make 8-Bit Art!][]
site seemed like a good starting point, so I grabbed the [code][] and
started poking around.

The first problem was that I needed to export a pixel-by-pixel version
of the drawn image, such that each square maps to a single pixel that
in turn will map to a single LED. So I needed a 64x32 image, but the
PNGs generated by Make 8-Bit Art are scaled up much larger.

That didn't end up being very difficult in the end. I just sample one
pixel in the middle of each square and build that into a new image. I
created a [pull request][] with my modifications, although I don't
know how generally useful this would be.

Next was the task of creating a web service to take the resulting
image and display it. I followed the [Adafruit guide][] that
recommends using the [rpi-rgb-led-matrix][] library by [hzeller][] and
got the demo going. The web service itself was simple, as I only
needed to support uploading a picture and sending it to the LED
matrix, with code for the latter already existing in the
rpi-rgb-led-matrix package.

However, writing to the matrix requires root privileges, and I didn't
want to run my web server as root. So instead, I made a very simple
[daemon][] that runs as root and takes commands over Redis. The
[Flask app][] now handles only file uploads and sending Redis messages
to display an image or clear the matrix.

I found out later that the guide I was following was using an
[out-of-date fork][] of rpi-rgb-led-matrix. Adafruit had forked it to
add Python support; however, it was done a bit hackily, so I had to
run my daemon from the rpi-rgb-led-matrix directory. I just noticed
that Adafruit has updated their guide to use the latest code in that
library, which had more thorough Python support added some time ago,
so I'll be updating mine at some point. Hopefully this will let me run
the daemon from its own directory.

I also set up a WSGI server and got it running with systemd and nginx
(see the [README][] for details). Unfortunately I had less luck
running the daemon automatically. Running it via systemd would result
in my Raspberry PI locking up. Running it from a terminal works
fine. I'm guessing the difference is somehow environment related, but
as of yet I haven't been able to figure it out. For now, I run the
daemon in a screen session. Maybe this is something else that will be
fixed by converting to the latest rpi-rgb-led-matrix code.

Last was hacking up Make 8-Bit Art to use my new web service. I added
some code to the pixel-by-pixel feature to use the [Fetch API][] to
send the created image up to the Pi and then display it. It's hacky
but works fine! Since this is almost certainly of little use to the
upstream repository, I created a [branch][] but haven't bothered
submitting a pull request.

Since getting this working, I've actually had a few people play with
it, including my daughter. The display is really nice, with very vivid
colours, so it's an interesting combination of retro and modern
technologies.

Here's an example of something simple drawn in the app:

![Make 8 bit art screenshot](/images/screenshot-make-8-bit-art.png)

And the resulting image on the matrix:

![LED matrix photo without flash](/images/led-matrix-hi.jpg)

It's a really intense matrix, and I suck at photography, so here's
another shot, with the flash on, so you can see the matrix itself a
bit better:

![LED matrix photo with flash](/images/led-matrix-hi-flash.jpg)

My next step is to simplify my fork of Make 8-Bit Art (I don't need
any of the other export options, maybe just "Save" and "Display"
buttons).  After that, I'd like to extend it to allow more than one
image to exist on the Pi at a time.  Then I could add a feature to my
web service to choose from previously uploaded images, and even to
create animations.

All in all this has been a fun little project, and as with most, if
not all, open-source software, I couldn't have done it without a lot
of help.  Thanks to Adafruit, Jenn Schiffer, and hzeller in particular!

[BuyaPi.ca]: https://www.buyapi.ca
[Raspberry Pi 3 Model B]: https://www.raspberrypi.org/products/raspberry-pi-3-model-b/
[Times Square zipper]: https://www.wired.com/2008/11/nov-6-1928-all-the-news-thats-lit-2/
[making one]: https://www.makeuseof.com/tag/weekend-project-build-giant-led-pixel-display/
[64x32 RGB LED matrix]: https://www.adafruit.com/product/2279
[assembly]: https://learn.adafruit.com/adafruit-rgb-matrix-plus-real-time-clock-hat-for-raspberry-pi
[Jenn Schiffer]: http://jennmoney.biz/
[Make 8-Bit Art!]: https://make8bitart.com/
[code]: https://github.com/jennschiffer/make8bitart
[pull request]: https://github.com/jennschiffer/make8bitart/pull/66
[Adafruit guide]: https://learn.adafruit.com/adafruit-rgb-matrix-plus-real-time-clock-hat-for-raspberry-pi/driving-matrices
[rpi-rgb-led-matrix]: https://github.com/hzeller/rpi-rgb-led-matrix
[hzeller]: https://github.com/hzeller
[daemon]: https://github.com/markrcote/ledweb/blob/master/ledservice.py
[Flask app]: https://github.com/markrcote/ledweb/blob/master/ledweb.py
[branch]: https://github.com/markrcote/make8bitart/tree/ledweb
[out-of-date fork]: https://github.com/hzeller/rpi-rgb-led-matrix/issues/9#issuecomment-61035344
[README]: https://github.com/markrcote/ledweb/blob/master/README.md
[Fetch API]: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API

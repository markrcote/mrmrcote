---
title: "A-Team: Visualizing IonMonkey"
date: 2012-09-25T16:56:00-04:00
categories: ["mozilla"]
---
EDIT: Sorry, the image links were broken everywhere but on the main page of
my blog. Fixed now. Still getting used to Octopress. :)

It's been a while since I last wrote about it, but the A-Team is still
maintaining the [SpeedTests](http://mrcote.info/speedtests/) framework,
gathering the results of a few different benchmarks on all the major browsers
on a 32-bit Windows 7 installation. I haven't had any time to add new tests,
but I made sure to keep the results coming in for the tests we do have.

With IonMonkey having [landed](https://blog.mozilla.org/javascript/2012/09/12/ionmonkey-in-firefox-18/)
a couple weeks ago, I expected to see some big improvements. Sure enough,
we can see a big jump in Kraken, as David Anderson saw:

<a href="http://mrcote.info/speedtests/results.html#/Kraken/Win7/2012-09-06/2012-09-25"><img src="/images/2012-09-25/kraken.png" /></a>

That's about a 27% improvement, right about what David measured on his
machine. That makes Firefox about 16% faster than Chrome 21 (which itself
improved by about 6% from Chrome 20).

As for V8,

<a href="http://mrcote.info/speedtests/results.html#/V8/Win7/2012-09-06/2012-09-25"><img src="/images/2012-09-25/v8.png" /></a>

The data is a bit noisy, but it looks like an improvement of around 9-10%
on the overall results (geometric mean of the total test results). Not as
much of an improvement, and Chrome is still 25% better, overall.

The "Speed" Tests also run (a sort of old version of) test262, a conformance
suite:

<a href="http://mrcote.info/speedtests/results.html#/test262/Win7/2012-09-06/2012-09-25"><img src="/images/2012-09-25/test262.png" /></a>

No changes there, which is what we would expect.

I looked through the other tests, and it doesn't look like IonMonkey has made
much of a difference. But of course all these tests are very specific and/or
artificial. If there are any JavaScript-based tests that should show clear
improvements, feel free to <a href="mailto:mcote@mozilla.com">let me know</a>
and maybe I'll find the time to add them!


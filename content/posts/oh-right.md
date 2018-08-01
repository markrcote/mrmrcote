---
title: "oh right, virtualenv"
date: 2012-10-12T00:42:00-04:00
categories: ["mozilla"]
---
An amusingly frequent pattern:

    git clone https://github.com/mozilla/new-python-project
    # ... right, virtualenv
    mkdir src
    mv new-python-project src
    virtualenv new-python-project
    cd new-python-project
    mv ../src .
    . bin/activate
    # get to work

I really ought to make a script to clone new Python projects...

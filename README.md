Organews
================

[![Dependency Status](https://gemnasium.com/greenruby/organews.png)](https://gemnasium.com/greenruby/organews)
[![Build Status](https://travis-ci.org/greenruby/organews.png?branch=develop)](https://travis-ci.org/greenruby/organews)
[![Coverage Status](https://coveralls.io/repos/greenruby/organews/badge.png?branch=develop)](https://coveralls.io/r/greenruby/organews?branch=develop)
[![Code Climate](https://codeclimate.com/github/greenruby/organews.png)](https://codeclimate.com/github/greenruby/organews)

Status: setup in progress

Taskboard: [trello taskboard](https://trello.com/board/greeby-platform/513fd48aa7ed906115001a04)

This code is intended to power http://greenruby.org as a helper
for writing a ruby newsletter, collecting news, triaging them,
collaboratively evaluating them, in a limited group of people.
It could be viewed as a kind of small hackernews on the top of newsblur,
with some extra tools for generating mailchimp letters.

The technology stack in this project is probably very mobile,
and for now we are talking about a combination of:

* sinatra 1.4 on ruby 2
  as a main server, to serve static pages for the front-end and
  handle the REST interface to the db
* mongodb
  as a data store.
* compass
  as a preprocessing helper of SCSS files and sprites generation
* fontcustom
  for generating icon fonts from inkscape SVG files.
* Ember.js, with emblem.js and jquery
  for the front-end rendering and general navigation
* Rspec and Zombie (not sure yet about that one)
  one for the backend REST server, the other for the front-end

Run it
---------

```
bundle
foreman start
open http://localhost:5100
```
The sinatra server is serving the frontend and the backend. Foreman also launches grunt at same time.


Contribute
--------------

* we use git flow, so master is the released version, and all work is done on develop branch
* fork, branch, pull request against develop branch
* do not change the changelog it will be modified at merge
* do not increment the version number it will be done at release

Contributors
---------------

* @mose project lead
* @eguitarz dev
* @tubaxenor dev

License - MIT
-----------

Copyright (c) 2013 Mose, Dale Ma, William Chang

```
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
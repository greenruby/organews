Greeby
================

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
* Ember.js, bringing handlebar.js and jquery
  for the front-end rendering and general navigation
* Rspec and Zombie (not sure yet about that one)
  one for the backend REST server, the other for the front-end
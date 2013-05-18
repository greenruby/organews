// require('moment');

App = Ember.Application.create({});


App.Router.map( function() {
  this.resource( 'index', { path: '/' } );
  this.resource( 'archives', function() {
    this.route( 'letter', { path: '/newsletter/:num' } );
  });
  this.resource( 'letters', function() {
    this.route( 'new' );
    this.route( 'edit' );
  });
  this.resource( 'articles', function() {
    this.route( 'show', { path: '/:article_id' } );
    this.route( 'new' );
    this.route( 'edit', { path: '/:article_id/edit' } );
  });
  this.route( 'about', { path: '/about' } );
});

App.Store = DS.Store.extend({
  revision: 12,
  adapter: 'DS.RESTAdapter'
});

App.ApplicationRoute = Ember.Route.extend({});

App.ArticleRoute = Ember.Route.extend({
  model: function(params) {
    return App.Article.find(params.num);
  },
  setupController: function(controller) {
    jQuery.getJSON('/articles').then(function(json){
      controller.set('articles', json.articles);
      controller.set('isLoaded', true);
    });
  }
});
App.IndexRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.getJSON('/articles').then(function(json){
      controller.set('articles', json.articles);
    });
  }
});
App.LetterRoute = Ember.Route.extend({
  model: function(params) {
    return App.Letter.find(params.num);
  }
});

App.Article = DS.Model.extend({
  title: DS.attr('string'),
  url: DS.attr('string'),
  pubdate: DS.attr('date'),
  comment: DS.attr('string'),
  tags: DS.hasMany('App.Tag'),
  letter: DS.belongsTo('App.Letter'),
  section: DS.belongsTo('App.Section'),
  reporter: DS.belongsTo('App.User')
});
App.Letter = DS.Model.extend({
  num: DS.attr('number'),
  edito: DS.attr('string'),
  pubdate: DS.attr('date'),
  articles: DS.hasMany('App.Section'),
  number: function() {
    return ("000" + this.get('num')).slice(-3);
  }.property('num')
});
App.Section = DS.Model.extend({
  label: DS.attr('string'),
  intro: DS.attr('string'),
  order: DS.attr('number')
});
App.Tag = DS.Model.extend({
  label: DS.attr('string')
});
App.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string')
});
// Avoid `console` errors in browsers that lack a console.
(function() {
    var method;
    var noop = function () {};
    var methods = [
        'assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
        'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
        'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
        'timeStamp', 'trace', 'warn'
    ];
    var length = methods.length;
    var console = (window.console = window.console || {});

    while (length--) {
        method = methods[length];

        // Only stub undefined methods.
        if (!console[method]) {
            console[method] = noop;
        }
    }
}());

Ember.TEMPLATES["about"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<script type=\"text/x-emblem\">.meat  = content");
  
});

Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<script type=\"text/x-emblem\">#container: #wrapper  #titlebar    #logo: img alt=\"Green Ruby\" height=\"81\" src=\"img/green-ruby-100.png\" width=\"100\"  h1 Green Ruby News    .cell    form id=\"signup\" action=\"http://codegreenit.us6.list-manage1.com/subscribe/post?u=f1b3b59d2383eeb07537f6440&amp;id=7136c985cf\" method=\"post\" target=\"_blank\"}      | Subscribe to the Green Ruby Weekly Newsletter  input class=\"email\" name=\"EMAIL\" placeholder=\"email address\" type=\"email\"  input class=\"button\" name=\"subscribe\" type=\"submit\" value=\"Subscribe\"  #nav: ul    li: linkTo \"index\" | Home  li: linkTo \"about\" | About  li: linkTo \"letters\" | Archives    #content      = outlet    #footer    a href=\"http://codegreenit.com\"    img class=\"cg\" align=\"left\" alt=\"CG\" width=\"57\" height=\"57\" src=\"img/codegreen.png\"    a href=\"mailto:news@greenruby.org\" style=\"float:right\" | contact    | The Green Ruby Newsletter is published by Mose  br    | Sponsored by  a href=\"http://codegreenit.com\" | Code Green IT  br");
  
});

Ember.TEMPLATES["index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<script type=\"text/x-emblem\">.meat  | The Green Ruby Newsletter is a weekly newsletter sent by mail to a bunch of web developers.    It gathers links to new content from the very past week,  about web development, ruby language, but also javascript, html, css and other news  of interest for web developers, coders, scripters, etc.  br    blockquote    | purist &gt; WTF! Rubies are red, you heretic!  br  | editor &gt; yeah but if it passes all tests it gets green  br  | purist &gt; ...");
  
});

Ember.TEMPLATES["letters"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<script type=\"text/x-emblem\">.menu  h2 Archives  ul    each letter in letters    li    span | date  a href=url | #011.meat  | Archives");
  
});
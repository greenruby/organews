// require other, non-ember dependencies here, ie:
// require('moment');

window.App = Ember.Application.create({});

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
  adapter: DS.RESTAdapter.create({ bulkCommit: false })
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

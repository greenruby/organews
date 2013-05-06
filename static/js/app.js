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


App.ApplicationRoute = Ember.Route.extend({});

App.IndexRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.getJSON('/articles').then(function(json){
      controller.set('articles', json.articles);
    })
  }
});

App.LetterRoute = Ember.Route.extend({
  model: function(params) {
    return App.Letter.find(params.num);
  }
});

App.ArticleRoute = Ember.Route.extend({
  model: function(params) {
    return App.Article.find(params.num);
  },
  setupController: function(controller) {
    jQuery.getJSON('/articles').then(function(json){
      controller.set('articles', json.articles);
      controller.set('isLoaded', true);
    })
  }
});


// ============== models
App.Store = DS.Store.extend({
  revision: 12,
  adapter: DS.RESTAdapter.create({ bulkCommit: false })
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

App.Tag = DS.Model.extend({
  label: DS.attr('string')
});

App.User = DS.Model.extend({
  name: DS.attr('string'),
  email: DS.attr('string')
});
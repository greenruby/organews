window.App = Ember.Application.create({});

App.Router.map( function() {
  this.resource( 'index', { path: '/' } );
  this.resource( 'letters', function() {
    this.route( 'new' );
    this.route( 'edit' );
  });
  this.resource( 'articles', function() {
    this.route( 'new' );
    this.route( 'edit' );
  });
});

App.ApplicationRoute = Ember.Route.extend({});

App.Store = DS.Store.extend({
  revision: 1
});

App.Letter = DS.Model.extend({
  num: DS.attr('integer'),
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
  order: DS.attr('integer')
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
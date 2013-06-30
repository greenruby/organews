window.App = Em.Application.create();


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

App.AboutRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.ajax("/pages/about").done(function(data) {
      controller.set('content', data);
    });
  }
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
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashContexts, hashTypes;


  data.buffer.push("<div class=\"meat\">");
  hashContexts = {'unescaped': depth0};
  hashTypes = {'unescaped': "STRING"};
  stack1 = helpers._triageMustache.call(depth0, "content", {hash:{
    'unescaped': ("true")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</div>");
  return buffer;
  
});

Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, stack2, hashTypes, hashContexts, options, self=this, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  
  data.buffer.push("Home");
  }

function program3(depth0,data) {
  
  var buffer = '';
  return buffer;
  }

function program5(depth0,data) {
  
  
  data.buffer.push("About");
  }

function program7(depth0,data) {
  
  
  data.buffer.push("Archives");
  }

  data.buffer.push("<div id=\"container\"><div id=\"wrapper\"><div id=\"titlebar\"><div id=\"logo\"><img alt=\"Green Ruby\" height=\"81\" src=\"img/green-ruby-100.png\" width=\"100\" /></div><h1>Green Ruby NewsRoom</h1></div><div class=\"cell\"><div id=\"content\"><div class=\"nav\"><ul><li>");
  hashTypes = {};
  hashContexts = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["STRING"],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "index", options) : helperMissing.call(depth0, "linkTo", "index", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li><li>");
  hashTypes = {};
  hashContexts = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(5, program5, data),contexts:[depth0],types:["STRING"],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "about", options) : helperMissing.call(depth0, "linkTo", "about", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li><li>");
  hashTypes = {};
  hashContexts = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(7, program7, data),contexts:[depth0],types:["STRING"],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "letters", options) : helperMissing.call(depth0, "linkTo", "letters", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li></ul></div><div class=\"column\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "outlet", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</div></div><div id=\"footer\"><a href=\"http://codegreenit.com\"><img class=\"cg\" align=\"left\" alt=\"CG\" width=\"57\" height=\"57\" src=\"img/codegreen.png\" /></a><a href=\"mailto:news@greenruby.org\" style=\"float:right\">contact</a>The Green Ruby Newsletter is published by Mose<br />Sponsored by <a href=\"http://codegreenit.com\">Code Green IT</a><br /></div></div></div></div>");
  return buffer;
  
});

Ember.TEMPLATES["index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<div class=\"meat\">The Green Ruby Newsletter is a weekly newsletter sent by mail to a bunch of web developers.It gathers links to new content from the very past week,about web development, ruby language, but also javascript, html, css and other newsof interest for web developers, coders, scripters, etc.<br /><blockquote>purist &gt; WTF! Rubies are red, you heretic!<br />editor &gt; yeah but if it passes all tests it gets green<br />purist &gt; ...</blockquote></div>");
  
});

Ember.TEMPLATES["letters"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashTypes, hashContexts, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashContexts, hashTypes;
  data.buffer.push("<li><span>| date</span><a ");
  hashContexts = {'href': depth0};
  hashTypes = {'href': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'href': ("url")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">| #011</a></li>");
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = '';
  return buffer;
  }

  data.buffer.push("<div class=\"menu\"><h2>Archives</h2><ul>");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "letter", "in", "letters", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</ul></div><div class=\"meat\">Archives</div>");
  return buffer;
  
});
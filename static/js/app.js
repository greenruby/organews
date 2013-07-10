(function() {

  this.App = Em.Application.create({
    LOG_TRANSITIONS: true
  });

}).call(this);

(function() {

  this.App.Router.map(function() {
    this.resource('index', {
      path: '/'
    });
    this.resource('dashboard', {
      path: '/dashboard'
    });
    this.resource('archives', (function() {
      return this.route('letter', {
        path: '/newsletter/:num'
      });
    }));
    this.resource('letters', (function() {
      this.route('new');
      return this.route('edit');
    }));
    this.resource('articles', (function() {
      this.route('show', {
        path: '/:article_id'
      });
      this.route('new');
      return this.route('edit', {
        path: '/:article_id/edit'
      });
    }));
    return this.route('help', {
      path: '/help'
    });
  });

}).call(this);

(function() {

  this.App.Adapter = DS.RESTAdapter.create({
    namespace: "v1"
  });

  this.App.Store = DS.Store.extend({
    revision: 12,
    adapter: App.Adapter
  });

}).call(this);

(function() {

  this.App.ApplicationRoute = Ember.Route.extend({});

  this.App.ApplicationView = Ember.View.extend({
    classNames: ['appl-view']
  });

}).call(this);

(function() {

  this.App.ArticleRoute = Ember.Route.extend({
    model: function(params) {
      return App.Article.find(params.num);
    },
    setupController: function(controller) {
      return jQuery.getJSON('/articles').then(function(json) {
        controller.set('articles', json.articles);
        return controller.set('isLoaded', true);
      });
    }
  });

}).call(this);

(function() {

  this.App.DashboardRoute = Ember.Route.extend({});

  this.App.DashboardView = Ember.View.extend({
    classNames: ['dash-view']
  });

}).call(this);

(function() {

  this.App.HelpRoute = Ember.Route.extend({
    setupController: function(controller) {
      return jQuery.ajax("/pages/help").done(function(data) {
        return controller.set('content', data);
      });
    }
  });

}).call(this);

(function() {

  this.App.IndexRoute = Ember.Route.extend({
    redirect: function() {
      return this.replaceWith('dashboard');
    }
  });

}).call(this);

(function() {

  this.App.LetterRoute = Ember.Route.extend({
    model: function(params) {
      return App.Letter.find(params.num);
    }
  });

}).call(this);

(function() {

  this.App.LettersRoute = Ember.Route.extend({
    model: function() {
      return App.Letter.find();
    },
    setupController: function(c, m) {
      return console.log(m);
    }
  });

}).call(this);

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
  var buffer = '', hashTypes, hashContexts, escapeExpression=this.escapeExpression;


  data.buffer.push("<div id=\"titlebar\"><div id=\"logo\"></div><h1 class=\"head\">Organews</h1></div>");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "outlet", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  return buffer;
  
});

Ember.TEMPLATES["dashboard"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<div id=\"feeds-panel\"><ul class=\"feeds\"><li>feed 1</li><li>feed 2</li><li>feed 3</li><li>feed 4</li><li>feed 5</li><li>feed 6</li><li>feed 7</li><li>feed 8</li><li>feed 9</li><li>feed 10</li><li>feed 11</li><li>feed 12</li></ul></div><div id=\"items-panel\"><ul class=\"items\"><li>item 1</li><li>item 2</li><li>item 3</li><li>item 4</li><li>item 5</li><li>item 6</li><li>item 7</li><li>item 8</li><li>item 9</li><li>item 10</li><li>item 11</li><li>item 12</li><li>item 13</li><li>item 14</li><li>item 15</li><li>item 16</li><li>item 17</li><li>item 18</li><li>item 19</li><li>item 20</li></ul></div><div id=\"output-panel\"><div>Select your items on the left</div></div>");
  
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
  stack1 = helpers.each.call(depth0, "letter", "in", "controller", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</ul></div><div class=\"meat\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "outlet", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</div>");
  return buffer;
  
});

Ember.TEMPLATES["letters/index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<p>Archives</p>");
  
});
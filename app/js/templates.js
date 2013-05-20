Ember.TEMPLATES["about"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashTypes, escapeExpression=this.escapeExpression;


  data.buffer.push("<div class=\"meat\">");
  hashTypes = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "content", {hash:{},contexts:[depth0],types:["ID"],hashTypes:hashTypes,data:data})));
  data.buffer.push("</div>");
  return buffer;
  
});

Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, stack2, hashTypes, options, self=this, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression;

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

  data.buffer.push("<div id=\"container\"><div id=\"wrapper\"><div id=\"titlebar\"><div id=\"logo\"><img alt=\"Green Ruby\" height=\"81\" src=\"img/green-ruby-100.png\" width=\"100\" /></div><h1>Green Ruby News</h1></div><div class=\"cell\"><form id=\"signup\" action=\"http://codegreenit.us6.list-manage1.com/subscribe/post?u=f1b3b59d2383eeb07537f6440&amp;id=7136c985cf\" method=\"post\" target=\"_blank\">Subscribe to the Green Ruby Weekly Newsletter<input class=\"email\" name=\"EMAIL\" placeholder=\"email address\" type=\"email\" /><input class=\"button\" name=\"subscribe\" type=\"submit\" value=\"Subscribe\" /></form><div id=\"nav\"><ul><li>");
  hashTypes = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["STRING"],hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "index", options) : helperMissing.call(depth0, "linkTo", "index", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li><li>");
  hashTypes = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(5, program5, data),contexts:[depth0],types:["STRING"],hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "about", options) : helperMissing.call(depth0, "linkTo", "about", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li><li>");
  hashTypes = {};
  options = {hash:{},inverse:self.program(3, program3, data),fn:self.program(7, program7, data),contexts:[depth0],types:["STRING"],hashTypes:hashTypes,data:data};
  stack2 = ((stack1 = helpers.linkTo),stack1 ? stack1.call(depth0, "letters", options) : helperMissing.call(depth0, "linkTo", "letters", options));
  if(stack2 || stack2 === 0) { data.buffer.push(stack2); }
  data.buffer.push("</li></ul></div><div id=\"content\">");
  hashTypes = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "outlet", {hash:{},contexts:[depth0],types:["ID"],hashTypes:hashTypes,data:data})));
  data.buffer.push("</div><div id=\"footer\"><a href=\"http://codegreenit.com\"><img class=\"cg\" align=\"left\" alt=\"CG\" width=\"57\" height=\"57\" src=\"img/codegreen.png\" /></a><a href=\"mailto:news@greenruby.org\" style=\"float:right\">| contact</a>The Green Ruby Newsletter is published by Mose<br />Sponsored by<a href=\"http://codegreenit.com\">| Code Green IT</a><br /></div></div></div></div>");
  return buffer;
  
});

Ember.TEMPLATES["index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  


  data.buffer.push("<div class=\"meat\">The Green Ruby Newsletter is a weekly newsletter sent by mail to a bunch of web developers.It gathers links to new content from the very past week,about web development, ruby language, but also javascript, html, css and other newsof interest for web developers, coders, scripters, etc.<br /><blockquote>purist &gt; WTF! Rubies are red, you heretic!<br />editor &gt; yeah but if it passes all tests it gets green<br />purist &gt; ...</blockquote></div>");
  
});

Ember.TEMPLATES["letters"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashTypes, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashTypes;
  data.buffer.push("<li><span>| date</span><a ");
  hashTypes = {'href': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'href': ("url")
  },contexts:[],types:[],hashTypes:hashTypes,data:data})));
  data.buffer.push(">| #011</a></li>");
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = '';
  return buffer;
  }

  data.buffer.push("<div class=\"menu\"><h2>Archives</h2><ul>");
  hashTypes = {};
  stack1 = helpers.each.call(depth0, "letter", "in", "letters", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</ul></div><div class=\"meat\">Archives</div>");
  return buffer;
  
});
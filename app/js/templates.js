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
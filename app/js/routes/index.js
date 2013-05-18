App.IndexRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.getJSON('/articles').then(function(json){
      controller.set('articles', json.articles);
    })
  }
});
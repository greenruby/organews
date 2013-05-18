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
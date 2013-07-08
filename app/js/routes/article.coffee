@App.ArticleRoute = Ember.Route.extend {
  model: (params)->
    App.Article.find params.num
  setupController: (controller)->
    jQuery.getJSON('/articles').then( (json)->
      controller.set('articles', json.articles)
      controller.set('isLoaded', true)
    )
}
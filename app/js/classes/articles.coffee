@App.Article = DS.Model.extend {
  title: DS.attr 'string'
  url: DS.attr 'string'
  created_at: DS.attr 'date'
  comment: DS.attr 'string'
  tags: DS.hasMany 'App.Tag'
  publication: DS.belongsTo 'App.Publication'
  section: DS.belongsTo 'App.Section'
  reporter: DS.belongsTo 'App.User'
}

@App.Section = DS.Model.extend {
  label: DS.attr 'string'
  intro: DS.attr 'string'
  order: DS.attr 'number'
}

@App.ArticleRoute = Ember.Route.extend {
  model: (params)->
    App.Article.find params.num
  setupController: (controller)->
    jQuery.getJSON('/articles').then( (json)->
      controller.set('articles', json.articles)
      controller.set('isLoaded', true)
    )
}


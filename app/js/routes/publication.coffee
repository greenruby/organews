@App.PublicationRoute = Ember.Route.extend {
  model: (params)->
    App.Publication.find params.num
}
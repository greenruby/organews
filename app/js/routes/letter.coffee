@App.LetterRoute = Ember.Route.extend {
  model: (params)->
    App.Letter.find params.num
}
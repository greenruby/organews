@App.PublicationsRoute = Ember.Route.extend
  model: ()->
    App.Publication.find()
  setupController: (c, m)->
    console.log(m)

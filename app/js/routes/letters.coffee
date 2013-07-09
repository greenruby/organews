@App.LettersRoute = Ember.Route.extend 
  model: ()->
    @App.Letter.find()
  setupController: (c, m)->
    console.log(m)

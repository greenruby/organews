@App.Publication = DS.Model.extend {
  number: DS.attr 'number'
  edito: DS.attr 'string'
  created_at: DS.attr 'date'
  articles: DS.hasMany 'App.Section'
  padded_number: (->
    ("000" + @get('number')).slice(-3);
  ).property('number')
}

@App.PublicationRoute = Ember.Route.extend
  model: (params)->
    App.Publication.find params.num

@App.PublicationsRoute = Ember.Route.extend
  model: ()->
    App.Publication.find()
  setupController: (c, m)->
    console.log(m)

@App.PublicationsNewRoute = Ember.Route.extend
  setupController: (c, m)->
    @_super(c, m)
    c.create()

@App.PublicationsController = Em.ArrayController.extend {}
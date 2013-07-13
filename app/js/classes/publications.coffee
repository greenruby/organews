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
  renderTemplate: ->
    @render 'Publications'
  model: ->
    # mock model, kill me after build the real data
    # App.Publication.find()
    [{ title: 'Emerald News #1', url: 'http:/www.google.com', date: new Date(), number: 1}]
  setupController: (c, m)->
    c.set('model', m)
    console.log(m)

@App.PublicationsView = Em.View.extend
  classNames: ['publications-view']

@App.PublicationsNewRoute = Ember.Route.extend
  setupController: (c, m)->
    @_super(c, m)
    c.create()

@App.PublicationsController = Em.ArrayController.extend {}

@App.PublicationShowRoute = Ember.Route.extend
  model: (params)->
    App.Publication.find params.num
  renderTemplate: ->
    @render( 'PublicationShow', { controller: 'PublicationShow' } )

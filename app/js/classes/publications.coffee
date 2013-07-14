@App.Publication = DS.Model.extend {
  number: DS.attr 'number'
  edito: DS.attr 'string'
  created_at: DS.attr 'date'
  articles: DS.hasMany 'App.Section'
  padded_number: (->
    ("000" + @get('number')).slice(-3)
  ).property('number')
}

@App.PublicationRoute = Em.Route.extend
  model: (params)->
    App.Publication.find params.num


# Collection: Publications

@App.PublicationsRoute = Em.Route.extend
  model: ->
    # mock model, kill me after build the real data
    # App.Publication.find()
    [{ title: 'Emerald News #1', url: 'http:/www.google.com', created_at: new Date(), number: 1}]
  setupController: (c, m)->
    $('#new_publication').hide()
    c.set('model', m)
  events:
    new_publication: ->
      $('#new_publication').show()
    cancel_new_publication: ->
      $('#new_publication').hide()
    save_new_publication: ->
      $('#new_publication').hide()

@App.PublicationsView = Em.View.extend
  classNames: ['inmiddle']




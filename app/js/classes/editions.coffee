@App.EditionsRoute = Em.Route.extend
  model: ->
    # mock model, kill me after build the real data
    App.Edition.find( publication_id: params.publication_id)
    #[{ number: 1, title: 'Emerald News #1', edito: 'This is the edito', created_at: new Date() }]
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


@App.Edition = DS.Model.extend {
  id: DS.attr 'number'
  number: DS.attr 'number'
  edito: DS.attr 'string'
  created_at: DS.attr 'date'
  url: DS.attr 'string'
  publication: DS.belongsTo 'App.Publication'
  articles: DS.hasMany 'App.Article'
  padded_number: (->
    ("000" + @get('number')).slice(-3)
  ).property('number')
}

@App.Edition.FIXTURES = [
  {
    id: 1,
    number: 1,
    edito: "This is my edito...",
    created_at: new Date(),
    url: '',
    publication_id: 1,
    article_ids: [ ]
  },
  {
    id: 2,
    number: 2,
    edito: "This is my second edito...",
    created_at: new Date(),
    url: '',
    publication_id: 1,
    article_ids: [  ]
  }
]
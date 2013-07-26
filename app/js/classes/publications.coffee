# data models

@App.Publication = DS.Model.extend
  id: DS.attr 'number'
  name: DS.attr 'string'
  title: DS.attr 'string'
  template: DS.attr 'string'
  url: DS.attr 'string'
  editions: DS.hasMany 'App.Edition'
  sections: DS.hasMany 'App.Section'


@App.Section = DS.Model.extend
  id: DS.attr 'number'
  label: DS.attr 'string'
  intro: DS.attr 'string'
  order: DS.attr 'number'
  publication: DS.belongsTo 'App.Publication'


@App.Publication.FIXTURES = [
  {
    id: 1,
    name: 'Green Ruby',
    title: 'Green ruby #000',
    template: 'grn',
    url: 'http://greenruby.org',
    edition_ids: [ 1, 2 ],
    section_ids: [ 1 ]
  },
  {
    id: 2,
    name: 'La Gazette',
    title: 'Gazette numero 000',
    template: 'gaz',
    url: '',
    edition_ids: [ ],
    section_ids: [ ]
  }
]

@App.Section.FIXTURES = [
  {
    id: 1,
    label: "Use",
    intro: "What to use",
    order: 1,
    publication_id: 1
  }
]

@App.PublicationRoute = Em.Route.extend
  model: (params)->
    App.Publication.find params.num


# Collection: Publications

@App.PublicationsRoute = Em.Route.extend
  model: ->
   App.Publication.all()
  setupController: (c, m)->
    $('#new_publication').hide()
    c.set('model', m)
  events:
    new_publication: ->
      $('#new_publication').show()
    cancel_new_publication: ->
      $('#new_publication').hide()
    save_new_publication: ->
      $.post( '/v1/publications', {title: title, edito: edito, created_at: created_at} ).done (json)->
        json = JSON.parse(json)
        $.get( '/v1/publications/' + json.id ).done (json)->
          json = JSON.parse(json)
          publication = {
            title: title
            edito: edito
            created_at: created_at
            articles: []
          }
          view.get('controller.content').pushObject( publication )
      $('#new_publication').hide()

@App.PublicationsController = Em.ArrayController.extend
  selectPublication: (publication)->
    @set( 'selectedPublication', publication)


@App.PublicationsView = Em.View.extend
  classNames: ['inmiddle']

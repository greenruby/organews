# data models

@App.Publication = DS.Model.extend
  name: DS.attr 'string'
  title: DS.attr 'string'
  template: DS.attr 'string'
  url: DS.attr 'string'
  created_at: DS.attr 'string'
  editions: DS.hasMany 'App.Edition'
  sections: DS.hasMany 'App.Section'


@App.Section = DS.Model.extend
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
    App.Publication.find params.id


# Collection: Publications

@App.PublicationsRoute = Em.Route.extend
  model: ->
   App.Publication.find()
  setupController: (c, m)->
    $('#new_publication').hide()
    c.set('model', m)
    c.set('collection', m)
  events:
    new_publication: ->
      $('#new_publication').show()
    cancel_new_publication: ->
      $('#new_publication').hide()
    save_new_publication: ->
      self = @
      name = self.controller.get('selectedNameFilter') || "Green Ruby"
      formData = {
        name: name
        title: encodeURIComponent(title.value), 
        edito: encodeURIComponent(edito.value), 
        created_at: encodeURIComponent(created_at.value) 
      }
      $.post( '/v1/publications', formData ).done (json)->
        json = JSON.parse(json)
        self.controller.set('model', App.Publication.find()) # reload model
        $("#new_publication input, #new_publication textarea").val ''
      $('#new_publication').hide()

@App.PublicationsController = Em.ArrayController.extend
  selectedItems: []
  needs: 'feeds'
  selectedItemsBinding: 'controllers.feeds.pickedItems'
  nameFilter: ['Green Ruby', 'La Gazette']
  selectedNameFilter: 'Green Ruby'
  selectPublication: (publication)->
    @set('selectedPublication', publication)
  selectItem: (item)->
    # TODO: adding into publication
  filterDidChange: (->
    if @get('selectedNameFilter') != ''
      filtered = @get('model').filterProperty('name', @get('selectedNameFilter'))
      @set('collection', filtered)
      
  ).observes('selectedNameFilter')

@App.PublicationsView = Em.View.extend
  classNames: ['inmiddle']

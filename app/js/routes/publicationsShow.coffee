@App.PublicationShowRoute = Ember.Route.extend {
  model: (params)->
    App.Publication.find params.num
  renderTemplate: ->
  	@render( 'PublicationShow', { controller: 'PublicationShow' } )
}
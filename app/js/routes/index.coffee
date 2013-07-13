@App.IndexRoute = Ember.Route.extend {
	redirect: ->
		@replaceWith 'feeds'
}
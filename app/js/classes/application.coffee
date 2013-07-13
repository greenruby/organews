@App.ApplicationRoute = Ember.Route.extend {}

@App.IndexRoute = Ember.Route.extend
  redirect: ->
    @replaceWith 'feeds'

@App.HelpRoute = Ember.Route.extend
  setupController: (controller)->
    jQuery.ajax("/pages/help").done( (data)->
      controller.set('content', data)
    )

@App.ApplicationView = Ember.View.extend {
	classNames: ['appl-view']
}
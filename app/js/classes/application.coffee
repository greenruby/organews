@App.ApplicationRoute = Ember.Route.extend {}

@App.IndexRoute = Ember.Route.extend
  redirect: ->
    @replaceWith 'feeds'

@App.PageRoute = Ember.Route.extend
  console.log(this)
  model: (params)->
    $.ajax("/pages/" + params.page_name).done( (data)->
      controller.set('content', data)
    )
  setupController: (controller)->
    $.ajax("/pages/help").done( (data)->
      controller.set('content', data)
    )


@App.PageController = Em.ArrayController.extend
  console.log(this)


@App.ApplicationView = Ember.View.extend {
	classNames: ['appl-view']
}
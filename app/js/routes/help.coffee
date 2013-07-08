@App.HelpRoute = Ember.Route.extend {
  setupController: (controller)->
    jQuery.ajax("/pages/help").done( (data)->
      controller.set('content', data)
    )
}
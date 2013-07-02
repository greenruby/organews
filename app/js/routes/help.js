App.HelpRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.ajax("/pages/help").done(function(data) {
      controller.set('content', data);
    });
  }
});

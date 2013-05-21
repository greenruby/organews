App.AboutRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.ajax("/pages/about").done(function(data) {
      controller.set('content', data);
    });
  }
});
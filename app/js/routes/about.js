App.AboutRoute = Ember.Route.extend({
  setupController: function(controller) {
    jQuery.ajax("/about").done(function(data) {
      controller.set('content', data);
    });
  }
});
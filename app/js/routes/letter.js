App.LetterRoute = Ember.Route.extend({
  model: function(params) {
    return App.Letter.find(params.num);
  }
});

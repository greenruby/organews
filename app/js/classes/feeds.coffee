@App.Item = DS.Model.extend
	title        : DS.attr 'string'
	url          : DS.attr 'string'
	published_at : DS.attr 'date'
	html         : DS.attr 'stirng'


@App.Feeds = DS.Model.extend
	title      : DS.attr 'string'
	url        : DS.attr 'string'
	created_at : DS.attr 'date'
	items      : DS.hasMany 'App.Item'


@App.FeedsRoute = Ember.Route.extend
	selectedFeed: {},

	# mock
	model: ->
		[
			{
				title: 'The Wreck Channel'
				url: 'http://www.google.com/rss'
				published_at: new Date()
				items: [
					{
						title: 'How to sleep on the street?'
						url: 'http://www.google.com'
						html: '<div>How to sleep on the street?</div>'
					}
					{
						title: 'The 10 best insects you should try'
						url: 'http://www.yahoo.com'
						html: '<div>The 10 best insects you should try</div>'
					}
				]
			}
			{
				title: 'UFO Hotline'
				url: 'http://www.blizzard.com/rss'
				published_at: new Date()
				items: [{
					title: 'Who kidnapped my grandpa?'
					url: 'http://www.google.com'
					html: '<div>Who kidnapped my grandpa?</div>'
				}]
			},
		]

@App.FeedsController = Ember.ArrayController.extend
	selectFeed: (feed)->
		@set( 'selectedFeed', feed)
	selectItem: (item)->
		@set( 'selectedItem', item)


@App.FeedsView = Ember.View.extend {
	classNames: ['inmiddle']
}
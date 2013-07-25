app = @App
@App.Item = DS.Model.extend
	title        : DS.attr 'string'
	url          : DS.attr 'string'
	published_at : DS.attr 'date'
	html         : DS.attr 'stirng'


@App.Feed = DS.Model.extend
	title      : DS.attr 'string'
	url        : DS.attr 'string'
	created_at : DS.attr 'date'
	items      : DS.hasMany 'App.Item'


# @App.FeedsRoute = Ember.Route.extend
	
@App.FeedsController = Ember.ArrayController.extend
	newFeedUrl: null
	urlPrompt: false
	selectFeed: (feed)->
		console.log feed
		@set( 'selectedFeed', feed)
	selectItem: (item)->
		@set( 'selectedItem', item)
	# newFeed: (data)->
	# 	console.log('new feed')
	# 	$.post('/v1/feed', data).then( (json)=>
	# 		console.log "created a feed: #{json.id}"
	# 		@set('urlPrompt', true)
	# 	)


@App.FeedsView = Ember.View.extend {
	classNames: ['inmiddle']
}

@App.NewFeedView = Ember.View.extend
	click: ->
		console.log('new feed view')

		@set('controller.urlPrompt', true)
		Ember.run.next(=>
			@$('input').focus()
		)
	keyUp: (e)->
		url = @get('controller.newFeedUrl')
		view = @
		if e.keyCode == 13 && !!url
			$.post( '/v1/feeds', {url: url} ).done (json)->
					json = JSON.parse(json)
					$.get( 'v1/feeds/' + json.id ).done (json)->
						json = JSON.parse(json)
						feed = {
							title: json.feed.title
							url: url
							created_at: new Date()
							items: json.feed.items
						}
						view.get('controller.content').pushObject( feed )
						view.set('controller.urlPrompt', false)
						view.set('controller.newFeedUrl', null)

		# if e.keyCode == 13 && !!url
		# 	@get('controller').newFeed {"url": encodeURIComponent(url)}
app = @App

# @App.FeedsRoute = Ember.Route.extend
	
@App.FeedsController = Ember.ArrayController.extend
	newFeedUrl: null
	urlPrompt: false
	selectFeed: (feed)->
		@get('content').forEach( (i)->
			i.set('selected', false)
		)
		feed.set('selected', true)
		@set( 'selectedFeed', feed)
	selectItem: (item)->
		@get('selectedFeed.items').forEach( (i)->
			i.set('selected', false)
		)
		item.set('selected', true)
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
						items = json.feed.items.map((i)->
							o = Ember.Object.create().setProperties(i)
							o.set('selected', false)
						)
						feed = Ember.Object.create {
							title: json.feed.title
							url: url
							created_at: new Date()
							items: items
							selected: false
						}
						view.get('controller.content').pushObject( feed )
						view.set('controller.urlPrompt', false)
						view.set('controller.newFeedUrl', null)

		# if e.keyCode == 13 && !!url
		# 	@get('controller').newFeed {"url": encodeURIComponent(url)}
app = @App
FEEDS_URL = '/v1/feeds'

@App.FeedsRoute = Ember.Route.extend
	setupController: (controller, model)->
		$.get('/v1/feeds').done (json)->
			# console.log json
			data = JSON.parse(json)
			console.log data
			feeds = data.map( (f)->
				o = Ember.Object.create().setProperties(f)
				o.items = f.items.map( (i)->
					Ember.Object.create().setProperties(i)
				)
				o
			) || []
			console.log feeds
			controller.set('content', feeds)


@App.FeedsController = Ember.ArrayController.extend
	newFeedUrl: null
	urlPrompt: false
	isProcessing: false
	isEditMode: false
	toggleEditMode: ->
		@set('isEditMode', !@get('isEditMode'))
	deleteFeed: (feed)->
		$.ajax {
			url: FEEDS_URL + '/' + feed.id,
			type: 'DELETE',
			success: =>	
				if @get('selectedFeed') == feed
					@set('selectedItem', null)
					@set('selectedFeed', null)
				@get('content').removeObject(feed)
		}
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


@App.FeedsView = Ember.View.extend
	classNames: ['inmiddle']


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
		if e.keyCode == 13 && !!url && !@get('isProcessing')
			@set('isProcessing', true)
			@$('input').attr('disabled', true)
			$.post( '/v1/feeds', {url: url} ).done (json)=>
				json = JSON.parse(json)
				$.get( 'v1/feeds/' + json.id ).done (json)=>
					@set('isProcessing', false)
					@$('input').attr('disabled', false)
					json = JSON.parse(json)
					items = json.items.map((i)->
						o = Ember.Object.create().setProperties(i)
						o.set('selected', false)
					)
					feed = Ember.Object.create {
						title: json.title
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
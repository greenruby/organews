app = @App
FEEDS_URL = '/v1/feeds'

@App.FeedsRoute = Ember.Route.extend
	setupController: (controller, model)->
		$.get('/v1/feeds', ->).done (json)->
			# console.log json
			data = JSON.parse(json)
			# console.log data
			feeds = data.map( (f)->
				o = Ember.Object.create().setProperties(f)
				o.items = Ember.ArrayController.create {
					sortProperties: ['published_at']
					sortAscending: false
				}
				o.items.setObjects f.items.map( (i)->
					if i.published_at
						i.published_at = (new Date( Date.parse(i.published_at) )).fmt('%Y-%m-%e %A')
					Ember.Object.create().setProperties(i)
				)

				o
			) || []
			# console.log feeds
			controller.set('content', feeds)
			if feeds.length == 0
				controller.set('noFeed', true)


@App.FeedsController = Ember.ArrayController.extend
	newFeedUrl: null
	urlPrompt: false
	isProcessing: false
	isEditMode: false
	noFeed: false
	pickedItems: []
	sortProperties: ['created_at']
	sortAscending: false
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
	pickItem: (item)->
		item.set('picked', !item.get('picked'))
		if item.get('picked')
			@get('pickedItems').pushObject(item)
		else
			@get('pickedItems').removeObject(item)






@App.FeedsView = Ember.View.extend
	classNames: ['inmiddle']


@App.NewFeedView = Ember.View.extend
	click: ->
		# console.log('new feed view')

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
			@$('input').parent().append('<span> Parsing feeds ...</span>')
			$.post( '/v1/feeds', {url: url} ).done (json)=>
				json = JSON.parse(json)
				id = json.id
				$.get( '/v1/feeds/' + id ).done (json)=>
					@set('isProcessing', false)
					@$('input').attr('disabled', false)
					@$('input').siblings('span').remove()
					json = JSON.parse(json)
					items = json.items.map((i)->
						o = Ember.Object.create().setProperties(i)
						o.set('selected', false)
					)
					feed = Ember.Object.create {
						id: id
						title: json.title
						url: url
						created_at: new Date()
						items: items
						selected: false
					}
					view.get('controller.content').pushObject( feed )
					view.set('controller.urlPrompt', false)
					view.set('controller.newFeedUrl', null)

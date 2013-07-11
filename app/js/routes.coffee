@App.Router.map(->
  @resource 'index', { path: '/' }
  @resource 'dashboard', { path: '/dashboard' }
  @resource 'archives', (->
    @route 'letter', { path: '/newsletter/:num' }
  )
  @resource 'letters', (->
    @route 'new'
    @route 'edit'
  )
  @resource 'articles', (->
    @route( 'show', { path: '/:article_id' } )
    @route 'new' 
    @route( 'edit', { path: '/:article_id/edit' } )
  )
  @route( 'help', { path: '/help' } )
)

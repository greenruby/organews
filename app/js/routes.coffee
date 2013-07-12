@App.Router.map(->
  @resource 'index', { path: '/' }
  @resource 'dashboard', { path: '/dashboard' }
  @resource 'publications', (->
    @route 'show', { path: '/publications/:num' }
    @route 'new'
    @route 'edit'
  )
  @resource 'articles', (->
    @route 'show'
    @route 'new'
    @route 'edit'
  )
  @route( 'help', { path: '/help' } )
)

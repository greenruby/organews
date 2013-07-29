@App.Router.map(->
  @resource 'index', { path: '/' }
  @resource 'feeds', { path: '/feeds' }
  @resource 'publications', { path: '/publications' }
  @resource 'articles', (->
    @route 'show'
    @route 'new'
    @route 'edit'
  )
  @route( 'page', { path: '/page/:page_name' } )
)

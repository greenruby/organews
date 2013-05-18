App.Router.map( function() {
  this.resource( 'index', { path: '/' } );
  this.resource( 'archives', function() {
    this.route( 'letter', { path: '/newsletter/:num' } );
  });
  this.resource( 'letters', function() {
    this.route( 'new' );
    this.route( 'edit' );
  });
  this.resource( 'articles', function() {
    this.route( 'show', { path: '/:article_id' } );
    this.route( 'new' );
    this.route( 'edit', { path: '/:article_id/edit' } );
  });
  this.route( 'about', { path: '/about' } );
});

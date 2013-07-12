@App.Article = DS.Model.extend {
  title: DS.attr 'string'
  url: DS.attr 'string'
  created_at: DS.attr 'date'
  comment: DS.attr 'string'
  tags: DS.hasMany 'App.Tag'
  publication: DS.belongsTo 'App.Publication'
  section: DS.belongsTo 'App.Section'
  reporter: DS.belongsTo 'App.User'
}
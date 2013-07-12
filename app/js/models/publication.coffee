@App.Publication = DS.Model.extend {
  number: DS.attr 'number'
  edito: DS.attr 'string'
  created_at: DS.attr 'date'
  articles: DS.hasMany 'App.Section'
  padded_number: (->
    ("000" + @get('number')).slice(-3);
  ).property('number')
}
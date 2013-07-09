@App.Letter = DS.Model.extend {
  num: DS.attr 'number'
  edito: DS.attr 'string'
  pubdate: DS.attr 'date'
  articles: DS.hasMany 'App.Section'
  number: (->
    ("000" + @get('num')).slice(-3);
  ).property('num')
}
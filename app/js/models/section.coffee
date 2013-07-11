@App.Section = DS.Model.extend {
  label: DS.attr 'string'
  intro: DS.attr 'string'
  order: DS.attr 'number'
}
Em.PickADate = Ember.View.extend(
  attributes: ["monthsFull", "monthsShort", "weekdaysFull", "weekdaysShort", "showMonthsFull", "showWeekdaysShort", "today", "clear", "format", "formatSubmit", "hiddenSuffix", "firstDay", "selectMonths", "selectYears", "min", "max", "disabled"]
  attributeBindings: ["name", "placeholder"]
  events: ["onOpen", "onClose", "onSet", "onStart"]
  tagName: "input"
  classNames: "pickadate"
  picker: null
  didInsertElement: ->
    options = {}
    self = this
    @get("events").forEach (event) ->
      callback = self[event]
      options[event] = callback  if callback

    @get("attributes").forEach (attr) ->
      options[attr] = self[attr]  if self[attr] isnt `undefined`
    options.format = 'yyyy-mm-dd'
    options.onSet = (e) ->
      # self.get("controller.content").set self.get("name"), @get()
      # picker = Ember.get(self, "picker")

    options.onStart = ->
      date = Ember.get(self, "value")
      if date
        date = date.replace(/-/g, "/")
        @set "select", new Date(date)
      else
        self.$().val ""

    $input = @$().pickadate(options)
    @set "picker", $input.pickadate("picker")

  valueChanged: (->
    if @get("picker")
      date = @get("value")
      console.log date
      if date
        date = date.replace(/-/g, "/")
        @get("picker").set "select", new Date(date)
      else
        @$().val ""
  ).observes("value")
)
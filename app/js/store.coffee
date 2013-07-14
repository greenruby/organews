if @App.Adapter == undefined
  @App.Adapter = DS.RESTAdapter.create
    namespace: "v1"

@App.Store = DS.Store.extend
  revision: 12,
  adapter: App.Adapter



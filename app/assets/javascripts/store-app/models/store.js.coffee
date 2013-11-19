class Nextdoorz.Models.Store extends Backbone.DeepModel
  url: ()->
    "/stores/#{@get 'id'}.json"
  typeName: 'Store'
  filtered_attributes: [
    'logo'
  ],
  nested_attributes: [
    'address'
    'schedule_items'
    'categories_associations'
  ],
  sync: (action, object, callbacks, options) ->
    filtered_object = object.clone()
    _.each(@filtered_attributes, (attr) ->
      delete filtered_object.attributes[attr]
    )
    _.each(@nested_attributes, (attr) ->
      filtered_object.attributes[attr + '_attributes'] = filtered_object.attributes[attr]
      delete filtered_object.attributes[attr]
    )
    Backbone.sync(action, filtered_object, callbacks, options)

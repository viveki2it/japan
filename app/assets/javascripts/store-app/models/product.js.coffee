# Pay attention when modifying this class that we inherit from it in Deal model.
# If you have to introduce features that aren't shared with deal. Move the shared features to
# a (new) common ancestor of these two models (and delete this warning :)
class Nextdoorz.Models.Product extends Backbone.DeepModel

  # Hold the id to sync with the server without the id field (See @url() method)
  copiedId: null

  urlRoot: '/products'

  typeName: 'Product'

  nested_attributes: [
    'variants'
  ]

  filtered_attributes: [
    'id'
    'updated_at'
    'stock'
    'store'
    'trash'
    'picture'
    'category'
    'tag'
  ]

  initialize: (options) ->

    if options? and options.trash
      @trash = true

    @copiedId = @get 'id' if @get('id')?

    if @attributes['variants']?
      @attributes['variants'] = new Backbone.Collection(@attributes['variants'])
    else
      @attributes['variants'] = new Backbone.Collection()

  # Adds the empty default product variant for new products
  addDefaultVariant: () ->
    unless @get('variants').length > 0
      @get('variants').add {name: 'standard', stock: 0, _destroy: 'false'}

  url: ->
    if @copiedId?
      url = "/products/#{@copiedId}"
    else
      url = "/products"
    url += ".json"
    if @trash? and @trash
      url += "?trash"
    url

  sync: (action, object, callbacks, options) ->
    filtered_object = jQuery.extend(true, {}, object)

    if action is "create" or action is "update"
      price = parseFloat(@get('price'))
      if price
        @set({price: price.toFixed(2)}, {silent: true})

      _.each @filtered_attributes, (attr) ->
        delete filtered_object.attributes[attr]

      _.each @nested_attributes, (attr) ->
        if filtered_object.attributes[attr].models?
          filtered_object.attributes[attr + '_attributes'] = filtered_object.attributes[attr].map (item) ->
            item.attributes
        else
          filtered_object.attributes[attr + '_attributes'] = filtered_object.attributes[attr]
        delete filtered_object.attributes[attr]

    Backbone.sync(action, filtered_object, callbacks, options)

    if action is 'read'
      @attributes['variants'] = new Backbone.Collection(@attributes['variants'])

  toJSON: ->
    product: _.clone @attributes

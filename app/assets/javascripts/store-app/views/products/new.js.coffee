class Nextdoorz.Views.NewProducts extends Nextdoorz.Views.AbstractForm
  template: Nextdoorz.getTemplate('products/form')
  variantTemplate: Nextdoorz.getTemplate('products/variant')
  bindings:
    name: '[name=name]'
    price: '[name=price]'
    description: '[name=description]'
  myEvents:
    'click .add-variant': 'addProductVariant'
    'click .delete-variant': 'deleteProductVariant'

  addProductVariant: () ->
    @model.get('variants').add {name: '', stock: 0, _destroy: 'false'}

  # Here we implements a small trick to have the Variant destroyed using rails
  # That's why we force _destroy: true and hides the field
  deleteProductVariant: (e) ->
    # We must have at least one variant
    count = @model.attributes.variants.filter (variant) ->
      not variant.attributes['_destroy']? || variant.attributes['_destroy'] == 'false'
    count = count.length

    if count > 1
      item = $(e.currentTarget).parents('.variant')
      input = $('.variant-destroy', item)
      input.val('true')
      input.change()
      $(item).hide()

  # We hide again the destroyed field for the case somebody reopens a new/edit modal
  # containing some destroyed fields
  hideDestroyedField: () ->
    @$('.variant-destroy[value=true]').parents('.variant').hide()

  initModel: ()->
    @model ||= new Nextdoorz.Models.Product
    @model.addDefaultVariant()

  render: () ->
    super()
    @_collectionBinder.bind @model.get('variants'), @$('#variants')
    @hideDestroyedField()
    this

  initialize: () ->
    _.extend(@events, @myEvents)
    super()
    elManagerFactory = new Backbone.CollectionBinder.ElManagerFactory(@variantTemplate(), "data-name");
    @_collectionBinder = new Backbone.CollectionBinder(elManagerFactory);

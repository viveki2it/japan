class Nextdoorz.Views.Stocks extends Backbone.View

  template: Nextdoorz.getTemplate 'stocks/index'

  variantCount: 0

  typeName: null

  events:
    "click .stocks-btn-update"      : "editProduct"
    "click .stocks-delete"          : "deleteProduct"
    "click .stocks-variant-delete"  : "deleteVariantProduct"
    "click .stocks-add"             : "addProduct"
    "click .stocks-btn-valid"       : "updateProduct"

  initialize: ->
    if @model.attributes.starts_at?
      @typeName = "deals"
    else
      @typeName = "products"

    @variantCount = @model.attributes.variants.length if @model.attributes.variants?
    @listenTo @model, 'change'  , @modelChanged
#     @listenTo @model, 'destroy' , @deleteProduct
    @render()

  render: ->
    @$el.html @template model: @model.attributes
    this

  modelChanged: ->
    typeElem = $(".total", $("[data-masonry-filter='.type-#{@typeName}']"))
    totalElem = $(".total", $("[data-masonry-filter='.stock-item']"))
    trashElem = $(".total", $("[data-masonry-filter='.type-trash']"))
    # If the model is in trash
    if @$el.hasClass('type-trash') and @model.attributes.stock
      @$el.removeClass('type-trash')
      @$el.addClass('type-' + @typeName)
      @$el.addClass('stock-item')
      @$el.removeClass('masonry-item')
      @$el.hide()
      typeElem.html parseInt(typeElem.html().replace(/\s/g, '')) + 1
      totalElem.html parseInt(totalElem.html().replace(/\s/g, '')) + 1
      trashElem.html parseInt(trashElem.html().replace(/\s/g, '')) - 1
    else if !@$el.hasClass('type-trash') and !@model.attributes.stock
      @$el.removeClass("type-#{@typeName}")
      @$el.addClass('type-trash')
      @$el.removeClass('stock-item')
      @$el.removeClass('masonry-item')
      @$el.hide()
      typeElem.html parseInt(typeElem.html().replace(/\s/g, '')) - 1
      totalElem.html parseInt(totalElem.html().replace(/\s/g, '')) - 1
      trashElem.html parseInt(trashElem.html().replace(/\s/g, '')) + 1

    @render()

  editProduct: (e) ->
    trShow = $(e.currentTarget).parents '.stocks-show'
    trShow.hide()
    $('#' + trShow.attr('id') + '-edit', @$el).show()
    false

  deleteVariantProduct: (e) ->
    countLeftVariants = =>
      i = 0
      for v in @model.attributes.variants
        if not v._destroy?
          i++
      i

    trEdit = $(e.currentTarget).parents '.stocks-edit'
    variant = @model.attributes.variants[parseInt($(e.currentTarget).next().attr('id'))]
    if countLeftVariants() > 1
      variant._destroy = true
      $(e.currentTarget).next().remove()
      $(e.currentTarget).next().remove()
      $(e.currentTarget).remove()
    else
      alert("Impossible de supprimer toutes les variantes d'un produit.")

  deleteProduct: (e) ->
    if @$el.hasClass('type-trash')
      if confirm("Etes vous sur ?") is true
        @model.destroy()
        @$el.hide 1000, =>
          $('#header').append '<div class="m-alert">Le produit a bien été supprimé</div>'
          trashElem = $(".total", $("[data-masonry-filter='.type-trash']"))
          trashElem.html parseInt(trashElem.html().replace(/\s/g, '')) - 1
          @remove()
          setTimeout ->
            $('.m-alert').hide()
          , 5000
    else
      for vari in @model.attributes.variants
        vari.stock = 0
      trShow = $(e.currentTarget).parents '.stocks-show'
      trShow.hide 1000, ->
        $('#header').append '<div class="m-alert">Le produit a bien été mis à la corbeille</div>'
        setTimeout ->
          $('.m-alert').hide()
        , 5000
      @model.save()

    false

  addProduct: (e) ->
    trEdit = $(e.currentTarget).parents '.stocks-edit'
    $('.stocks-new', trEdit).append( $('<div class="m-form-search-small" id="form'+@variantCount+'"><input type="text" class="stocks-new-input" placeholder="Votre variante" /><input type="submit" value="Ok" class="btn small color1 stocks-new-valid" /> <input type="number" value="1" id="number'+@variantCount+'" /></div>') )
    $('.stocks-add', trEdit).hide()

    $('.stocks-new-valid', trEdit).one 'click', =>
      trEdit.find('.stocks-add').show()
      @model.attributes.variants.push
        name: $('.stocks-new-input', trEdit).val()
        variable_id: @model.get 'id'
        stock: 0
      $('#form'+@variantCount).prepend( "<span class='stocks-number' id=" + (@model.attributes.variants.length - 1) + ">" + $(e.currentTarget).parent().find('.stocks-new-input').val() + "</span>" )
      $('#form'+@variantCount).find('.stocks-new-input').remove()
      $('#form'+@variantCount).find('.stocks-new-valid').remove()
      @variantCount++
      false

    false

  updateProduct: (e) ->
    trEdit = $(e.currentTarget).parents('.stocks-edit')
    trEdit.hide()
    that = @
    $('.stocks-number', trEdit).each ->
      variant = that.model.attributes.variants[parseInt($(this).attr('id'))]
      value = parseInt($(this).next().val())
      if variant?
        variant.stock = value
    that.model.save()
    trShow = $('#'+ trEdit.attr('id').replace('-edit', ''), @$el)
    trShow.show()

    false

  _findVariantByName: (name) ->
    varName = name
    for variant in @model.attributes.variants
      if variant.name is varName
        return variant
    null

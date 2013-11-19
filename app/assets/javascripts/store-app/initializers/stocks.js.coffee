Nextdoorz.Initializers.Stocks = ->
  totalElem = $(".total", $("[data-masonry-filter='.stock-item']"))
  dealElem = $(".total", $("[data-masonry-filter='.type-deals']"))
  productElem = $(".total", $("[data-masonry-filter='.type-products']"))
  trashElem = $(".total", $("[data-masonry-filter='.type-trash']"))

  addToView = (collec, elem, type, typeName) ->
    for model in collec.models
      id = model.attributes.id
      $('#stocks').append("<tbody id=table-stocks-" + typeName + "-" + model.attributes.id + " class='type-" + typeName + "'><tr><td>Loading...</td></tr></tbody>")
      $("#table-stocks-" + typeName + "-" + model.attributes.id).addClass("masonry-item")

      if typeName isnt 'trash'
        $(totalElem).html parseInt($(totalElem).html().replace(/\s/g, '')) + 1
        $("#table-stocks-" + typeName + "-" + model.attributes.id).addClass("stock-item")
        trash = false
      else
        $("#table-stocks-" + typeName + "-" + model.attributes.id).hide()
        trash = true

      $(elem).html parseInt($(elem).html().replace(/\s/g, '')) + 1

      do (id) ->
        fullModel = new type id: id, trash: trash
        fullModel.fetch
          success: (element) ->
            view = new Nextdoorz.Views.Stocks model: element, el: $("#table-stocks-" + typeName + "-" + id)

  products = new Nextdoorz.Collections.Products store_id: Context.current_user.store_id
  products.fetch
    success: (prods) ->
      addToView prods, productElem, Nextdoorz.Models.Product, "products"

  trashProducts = new Nextdoorz.Collections.Products store_id: Context.current_user.store_id, trash: true
  trashProducts.fetch
    success: (prods) ->
      addToView prods, trashElem, Nextdoorz.Models.Product, "trash"

  deals = new Nextdoorz.Collections.Deals store_id: Context.current_user.store_id
  deals.fetch
    success: (deals) ->
      addToView deals, dealElem, Nextdoorz.Models.Deal, "deals"

  trashDeals = new Nextdoorz.Collections.Deals store_id: Context.current_user.store_id, trash: true
  trashDeals.fetch
    success: (deals) ->
      addToView deals, trashElem, Nextdoorz.Models.Deal, "trash"

  $(".masonry-filter").on 'click', (e) ->
    $("a.masonry-filter").removeClass("current")
    $(this).addClass("current")
    $(".masonry-item").removeClass("masonry-item").hide()
    $($(this).attr("data-masonry-filter")).addClass("masonry-item").show()



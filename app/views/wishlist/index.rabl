object @jangalist
unless @jangalist.products.empty?
  child :products do
    extends 'products/index'
  end
end
unless @jangalist.deals.empty?
  child :deals do
    extends 'deals/index'
  end
end
unless @stores.empty?
  child @stores do
    attributes :id, :name
    
    node(:followed){
      # This function is defined in the user helper module
      |store| user_is_following_store?(store)
    }
  end
end
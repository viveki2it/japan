child @products do
  extends 'products/index'
end
child @deals do
  extends 'deals/index'
end
child @news do
  extends 'news/index'
end
child @stores do
  attributes :id, :name
    
  node(:followed){
    # This function is defined in the user helper module
    |store| user_is_following_store?(store)
  }
end
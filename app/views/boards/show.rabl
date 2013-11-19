object @board
attributes :id, :title, :user_id, :category_ids, :tag_ids, :district_ids, :created_at, :updated_at

if @board.stores.any?
  child :stores do
    attributes :id, :name
    
    node(:followed){
      # This function is defined in the user helper module
      |store| user_is_following_store?(store)
    }
    
  end
end

if @board.products.any?
  child :paginated_products do
    extends 'products/index'
  end
end
if @board.deals.any?
  child :paginated_deals do
    extends 'deals/index'
  end
end

# see news/index.rabl view to know what attributes are sent back in the Ajax request
if @board.news.any?
  child :paginated_news do
    extends 'news/index'
  end
end
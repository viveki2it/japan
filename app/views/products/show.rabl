object @product
attributes :id, :name, :price, :description, :updated_at, :tag_id, :stock, :tag, :category

child :store do
  attributes :id, :name, :user_id, :category_id
end

child :picture do |picture|
  attributes :id
  [:thumb, :middle, :original].each do |style|
    node style do
      picture.image.url style
      #"/assets/image_example_#{style}.jpg"
    end
  end
end

if @product.variants.any?
  child :variants do
    attributes :id, :variable_id, :name, :stock
  end
end

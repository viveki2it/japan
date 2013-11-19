collection @products
attributes :id, :name, :description, :price, :updated_at, :store_id, :tag_id, :stock

# Truncate product description
# The default_truncate function is defined in the application helper module
node(:description) {
  |product| default_truncate(product.description)
}

child :variants do |variant|
  attributes :id, :name, :stock
end

child :picture do |picture|
  [:thumb, :middle, :original].each do |style|
    node style do
      picture.image.url style
      #"/assets/image_example_#{style}.jpg"
    end
  end
end


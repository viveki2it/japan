collection @deals
attributes :id, :name, :stock, :discount_rate, :normal_price, :discount_price,
           :starts_at, :ends_at, :updated_at, :store_id, :tag_id

# Truncate deal description
# The default_truncate function is defined in the application helper module
node(:description) {
  |deal| default_truncate(deal.description)
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

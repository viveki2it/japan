collection @products
attributes :id, :name, :description, :price, :updated_at, :store_id, :tag_id, :stock
child :picture do |picture|
  [:thumb, :middle, :original].each do |style|
    node style do
      picture.image.url style
    end
  end
end


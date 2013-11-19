object @news
attributes :id, :title, :content, :updated_at
child :store do
  attributes :id, :name, :user_id, :category_id
end
child :picture do |picture|
  attributes :id
  [:thumb, :middle, :original].each do |style|
    node style do
      #TODO: don't forget to remove this "example image"
      # from products/deals/news for production
      picture.image.url style
      #"/assets/image_example_#{style}.jpg"
    end
  end
end
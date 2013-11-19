collection @news
attributes :id, :title, :updated_at, :store_id

# Just make the updated_at date prettier
node(:updated_date) { |news| l news.updated_at.to_date, :format => :short }


# Truncate deal description
# The default_truncate function is defined in the application helper module
node(:content) {
  |news| default_truncate(news.content)
}

# Add the picture url as a child to the @news attributes
child :picture do |picture|
  [:thumb, :middle, :original].each do |style|
    node style do
      picture.image.url style
      #"/assets/image_example_#{style}.jpg"
    end
  end
end
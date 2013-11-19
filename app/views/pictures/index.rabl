collection @pictures
attributes :id, :store_id, :decorated_id, :decorated_type
node(:image) do |picture|
  {
      micro: picture.image.url(:micro),
      thumb: picture.image.url(:thumb)
  }
end

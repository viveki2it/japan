object @picture
attributes :id, :store_id, :decorated_id, :decorated_type
node(:image) do |picture|
  {
      micro: picture.image.url(:micro),
      thumb: picture.image.url(:thumb),
      middle: picture.image.url(:middle),
      original: picture.image.url(:original)
  }
end
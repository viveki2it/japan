object @store
attributes :id, :name, :phone, :description, :updated_at, 
  :user_id, :wizard_step, :website_url, :facebook_url
child @store.logo => :logo do
  attributes :url
end
if @store.address
  child :address do
    attributes :id, :street_number, :street_name, :postal_code, :city
  end
end
if @store.schedule_items.any?
  child :schedule_items do
    attributes :id, :day, :start_at, :end_at, :pause_start_at, :pause_end_at, :status
  end
end
if @store.pictures.any?
  child @store.pictures.first(2) do
    child :image =>'image' do
      attributes :url
    end
  end
end
if @store.categories.any?
  child @store.categories do
    attributes :id, :title
  end
  child @store.categories_associations do
    attributes :id, :category_id
  end
end
=begin
@store.schedule_items.each do |schedule_item|
  if schedule_item.effective_day == :mon and schedule_item.discontinue_day == :fri
    node 'week' do
      attribute :start_at => schedule_item.start_at.strftime('%H:%M'), :end_at => schedule_item.end_at.strftime('%H:%M')
    end
  end
  if schedule_item.effective_day == :sat and schedule_item.discontinue_day == :sun
    node 'weekend' do
      attribute :start_at => schedule_item.start_at.strftime('%H:%M'), :end_at => schedule_item.end_at.strftime('%H:%M')
    end
  end
end
=end

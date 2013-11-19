collection @stores
attributes :id, :name, :phone, :description, :user_id, :updated_at, :category_id, :wizard_step
child :categories do
  attributes :id
end


attributes :id, :email, :role, :created_at, :updated_at,:wizard_step
node :store_id do |u|
  u.store.nil? ? nil  : u.store.id
end
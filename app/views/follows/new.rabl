object @store
attributes :id

node :followed do |store| 
  store.following_users.include? current_user
end

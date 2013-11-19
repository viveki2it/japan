class AddedBloggerColumnToConnections < ActiveRecord::Migration
   def change
    add_column :connections, :blogger_user_id, :string
    add_column :connections, :blogger_user_name, :string
    add_column :connections, :blogger_user_password, :string
  end
end

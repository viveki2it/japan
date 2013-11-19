class AddWordpressColumnsToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :token_type, :string
    add_column :connections, :blog_id, :integer
    add_column :connections, :blog_url, :string
    add_column :connections, :scope, :string
  end
end

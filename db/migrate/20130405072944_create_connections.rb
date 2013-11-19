class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :uid
      t.string :provider
      t.string :token
      t.string :secret
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end

class AddSecretTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secret_token, :string
    rename_column :users, :facebook_token, :token
    rename_column :users, :facebook_token_expires_in, :token_expires_in
  end
end

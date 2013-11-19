# -*- encoding : utf-8 -*-
class FacebookTokenToUser < ActiveRecord::Migration
  def up
    add_column :users,:facebook_token,:string
    add_column :users,:facebook_token_expires_in,:datetime
  end

  def down
    remove_column :users,:facebook_token
    remove_column :users,:facebook_token_expires_in
  end
end

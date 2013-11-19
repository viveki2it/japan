# -*- encoding : utf-8 -*-
class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows, id: false do |t|
      t.integer :store_id
      t.integer :user_id
    end
  end
end

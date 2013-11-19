# -*- encoding : utf-8 -*-
class ConnectPicturesToDecoratedModels < ActiveRecord::Migration
  def change
    add_column :pictures, :decorated_type, :string
    add_column :pictures, :decorated_id, :integer
  end
end

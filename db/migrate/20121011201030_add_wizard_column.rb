# -*- encoding : utf-8 -*-
class AddWizardColumn < ActiveRecord::Migration
  def up
    add_column :users, :wizard_step, :integer, :default => 1
  end

  def down
    remove_column :users, :wizard_step
  end
end

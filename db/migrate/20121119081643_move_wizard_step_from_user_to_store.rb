# -*- encoding : utf-8 -*-
class MoveWizardStepFromUserToStore < ActiveRecord::Migration
  def up
    add_column :stores,:wizard_step,:integer,:default => 1
    remove_column :users,:wizard_step
  end

  def down
    remove_column :stores,:wizard_step,:integer,:default => 1
    add_column :users,:wizard_step
  end
end

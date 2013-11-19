# -*- encoding : utf-8 -*-
class CreateDatabaseIndexes < ActiveRecord::Migration
  def change
=begin
./db/schema.rb:16 - always add db index (addresses => [store_id])
./db/schema.rb:26 - always add db index (day_schedules => [store_id])
./db/schema.rb:36 - always add db index (deals => [store_id])
./db/schema.rb:48 - always add db index (news => [store_id])
./db/schema.rb:56 - always add db index (pictures => [decorated_id, decorated_type])
./db/schema.rb:67 - always add db index (products => [store_id])
./db/schema.rb:89 - always add db index (stores => [user_id])

=end
    add_index :addresses, :store_id
    add_index :day_schedules, :store_id
    add_index :deals, :store_id
    add_index :news, :store_id
    add_index :products, :store_id
    add_index :pictures, [:decorated_id, :decorated_type]
    add_index :stores, :user_id
  end
end

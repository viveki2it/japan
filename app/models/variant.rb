class Variant < ActiveRecord::Base
  belongs_to :variable, polymorphic: true
  has_one :store, through: :variable

  attr_accessible :name, :variable_id, :variable_type, :stock

  validates :name, :stock, presence: true
  validates :stock, numericality: {greater_than_or_equal_to: 0}
end

# == Schema Information
#
# Table name: variants
#
#  id            :integer          not null, primary key
#  variable_id   :integer
#  name          :string(255)      default("variant"), not null
#  stock         :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  variable_type :string(255)      default("Product"), not null
#


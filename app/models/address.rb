# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  street_number :string(255)
#  street_name   :string(255)
#  postal_code   :string(255)
#  city          :string(255)      default("Paris")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  store_id      :integer
#  district      :integer
#  latitude      :float
#  longitude     :float
#  gmaps         :boolean
#

class Address < ActiveRecord::Base
  belongs_to :store, inverse_of: :address
  attr_accessible :city, :postal_code, :street_name, :street_number, :store

  validates_presence_of :street_number, :street_name, :city
  validates :postal_code, presence: true, numericality: {integer_only: true}, length: {is: 5}, format: {with: /\A75/}

  #validates :district, inclusion: {in: 1..20}

  acts_as_gmappable address: :to_s, process_geocoding: :geocode?

  def to_s
    "#{street_number} #{street_name}, #{postal_code} #{city}"
  end

  before_validation :set_district, unless: "postal_code.nil?"

  private

  def set_district
    self.district = postal_code.to_s[3, 5].to_i
    errors.add :postal_code, "Code postale non valide" unless district.in? 1..20
  end

  def geocode?
    street_number_changed? || street_name_changed? || postal_code_changed? || city_changed?
  end
end

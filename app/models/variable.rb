##
## variable.rb
## Login : <lta@still>
## Started on  Thu Mar 21 16:11:05 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

module Variable
  extend ActiveSupport::Concern

  included do
    has_many :variants, as: :variable, dependent: :destroy
    accepts_nested_attributes_for :variants, allow_destroy: true
    attr_accessible :variants_attributes

    scope :empty, joins(:variants).group("variants.variable_id, #{self.to_s.tableize}.id")
      .having('SUM(variants.stock) = 0')
    # We force default scope here to stay compatible with the user part of the application
    # Use 'Variable.unscoped.where...' if you want to disable it (e.g. Product.unscoped.empty.all)
    default_scope includes(:variants).where('variants.stock > 0')

    validate :has_at_least_a_variant?
  end

  module InstanceMethods
    def stock
      variants.reduce(0) { |i, variant| i += variant.stock }
    end

    private
    def has_at_least_a_variant?
      errors.add(:variants, "Chaque produit doit avoir au moins une variante") unless variants.size > 0
    end
  end
end

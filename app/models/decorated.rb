# -*- encoding : utf-8 -*-
module Decorated
  def self.included(base)
    base.class_eval do
      has_one :picture, as: :decorated, inverse_of: :decorated
      accepts_nested_attributes_for :picture
      attr_accessible :picture, :picture_id, :picture_attributes
    end
  end

  def image_url(style = :middle)
    self.picture.nil? ? "http://placehold.it/360x200.jpg" : self.picture.image.url(style)
  end
end

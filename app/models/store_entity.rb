# -*- encoding : utf-8 -*-
module StoreEntity
  extend ActiveSupport::Concern

  included do
    include Decorated
    belongs_to :store
    belongs_to :tag
    has_one :category, through: :tag

    attr_accessible :store, :store_id, :tag, :tag_id
    validates :store, presence: true
    validates :tag_id, presence: true

    delegate :name, to: :store, prefix: true
  end

  module ClassMethods
    # FIXME (lta) params belongs to controller code
    def filtered_list(params)
      if params[:store_id] != nil
        result = self.where store_id: params[:store_id]
      elsif params[:followed]
        result = current_user.send self.name.pluralize.to_sym
      else
        result = self
      end
      result.page(params[:page])
    end
  end
  
  def is_admin_valid?
    self.admin_validation
  end
end

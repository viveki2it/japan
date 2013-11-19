# -*- encoding : utf-8 -*-
class UserFollow < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
end
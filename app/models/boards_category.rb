# -*- encoding : utf-8 -*-
class BoardsCategory < ActiveRecord::Base
  belongs_to :board
  belongs_to :category
end
# -*- encoding : utf-8 -*-
class BoardsTag < ActiveRecord::Base
  belongs_to :board
  belongs_to :tag
end
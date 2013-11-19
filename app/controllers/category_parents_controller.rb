# -*- encoding : utf-8 -*-
class CategoryParentsController < ApplicationController
  # GET /category_parents
  # GET /category_parents.json
  def index
    @category_parents = CategoriesParent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_parents }
    end
  end

end

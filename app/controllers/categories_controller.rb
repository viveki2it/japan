# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  respond_to :json, except: [:new, :edit]

  # GET /categories.json
  def index
    authorize! :index, Category
    @categories = Category.all
  end
end

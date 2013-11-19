# -*- encoding : utf-8 -*-
class TagsController < ApplicationController
  respond_to :json, except: [:new, :edit]

  # GET /store/:store_id/tags.json
  def index
    authorize! :index, Category
    conditions ={}
    if params[:store_id]
      @store = Store.find params[:store_id]
      conditions[:tags] = {category_id: @store.categories.map{|c| c.id}}
    end
    @tags = TagsGroup.includes(:tags).where(conditions).all
    if @tags.any?
      render json: @tags.to_json(:include => :tags)
    else
      render json: @tags = Tag.where(conditions).to_json
    end
  end

end

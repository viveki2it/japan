# -*- encoding : utf-8 -*-
class NewsController < ApplicationController
  authorize_resource

  # GET /news.json
  def index
    @news = News.filtered_list params
    @store = Store.find(params[:store_id]) unless params[:store_id].nil?
  end

  # GET /news/1.json
  def show
    @news = News.joins(:store).find(params[:id])
    @store = @news.store
    redirect_to root_path unless publicly_visible?(@news)
  end
  
  def new
    @news = News.new()
    render :partial => "form", :layout => false
  end

  # POST /news.json
  def create
    @news = News.new(params[:news])
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news }
        format.json { render 'show' }
      else
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1.json
  def update
    @news = News.find(params[:id])
    respond_to do |format|
      if @news.update_attributes params[:news]
        format.html { redirect_to @news }
        format.json { render 'show' }
      else
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy
    respond_to do |format|
      format.html { redirect_to products_path }
      format.json { head :no_content }
    end
  end
end

# -*- encoding : utf-8 -*-
class DealsController < ApplicationController
  respond_to :json, except: [:new, :edit]
  authorize_resource

  # GET /deals.json
  def index
    if params.has_key? :trash
      @deals = Deal.unscoped.empty params
    else
      @deals = Deal.filtered_list params
    end
    @store = Store.find(params[:store_id]) unless params[:store_id].nil?
  end

  # GET /deals/1.json
  def show
    if params.has_key? :trash
      @deal = Deal.unscoped.empty.find(params[:id])
    else
      @deal = Deal.find(params[:id])
    end
    @store = @deal.store
    redirect_to root_path unless publicly_visible?(@deal)
  end

  # POST /deals.json
  def create
    @deal = Deal.new(params[:deal])
    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal }
        format.json { render 'show' }
      else
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deals/1.json
  def update
    @deal = Deal.unscoped.find(params[:id])
    respond_to do |format|
      if @deal.update_attributes params[:deal]
        format.html { redirect_to @deal }
        format.json { render 'show' }
      else
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    redirect_to deals_path
  end

  def add_to_wishlist
    @deal = Deal.find params[:deal_id]
    unless current_user.wishlist
      current_user.build_wishlist
      current_user.wishlist.save
    end
    wishlist = current_user.wishlist.deals
    respond_to do |format|
      if not wishlist.exists?(@deal.id) and wishlist << @deal
        format.json { head :ok }
      else
        format.html { render :text => "Already added", :status => 404 }
      end
    end
  end

  def remove_from_wishlist
    @deal = Deal.find params[:deal_id]
    wishlist = current_user.wishlist.deals
    respond_to do |format|
      if wishlist.delete @deal
        format.json { head :ok }
      else
        format.html { render :text => "Error Oo", :status => :unprocessable_entity }
      end
    end
  end
end

# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController
  authorize_resource

  # GET /products.json
  def index
    if params.has_key? :trash
      @products = Product.unscoped.empty params
    else
      @products = Product.filtered_list params
    end
    @store = Store.find(params[:store_id]) unless params[:store_id].nil?
  end

  # GET /products/1.json
  def show
    if params.has_key? :trash
      @product = Product.unscoped.empty.find(params[:id])
    else
      @product = Product.find(params[:id])
    end
    @store = @product.store
    redirect_to root_path unless publicly_visible?(@product)
  end

  # POST /products.json
  def create
    @product = Product.unscoped.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product }
        format.json { render 'show' }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1.json
  def update
    @product = Product.unscoped.find(params[:id])
  

    respond_to do |format|
      if @product.update_attributes params[:product]
        format.html { redirect_to @product }
        format.json { render 'show' }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1.json
  def destroy
    @product = Product.unscoped.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path }
      format.json { head :no_content }
    end
  end

  def add_to_wishlist
    @product = Product.find params[:product_id]
    unless current_user.wishlist
      current_user.build_wishlist
      current_user.wishlist.save
    end
    wishlist = current_user.wishlist.products
    respond_to do |format|
      if not wishlist.exists?(@product.id) and wishlist << @product
        format.json { head :ok }
      else
        format.html { render :text => "Already added", :status => :unprocessable_entity }
      end
    end
  end

  def remove_from_wishlist
    @product = Product.find params[:product_id]
    wishlist = current_user.wishlist.products
    respond_to do |format|
      if wishlist.delete @product
        format.json { head :ok }
      else
        format.html { render :text => "Error Oo", :status => :unprocessable_entity }
      end
    end
  end
end


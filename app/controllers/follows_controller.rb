# -*- encoding : utf-8 -*-
class FollowsController < ApplicationController
  # GET /index
  def index
    # TODO
    authorize! :show, :follows
    @stores = current_user.followed_stores.includes(:products => [:picture], :news => [:picture], :deals => [:picture])
    @products = Product.joins(:store => :following_users).where(:users => {:id => current_user.id}) || []
    @deals = Deal.joins(:store => :following_users).where(:users => {:id => current_user.id}) || []
    @news = News.joins(:store => :following_users).where(:users => {:id => current_user.id}) || []

  end

  # DELETE /follows
  def destroy
    authorize! :destroy, :follows
    @store = Store.find params[:store_id]
    if @store.following_users.include? current_user
      @store.following_users.delete current_user
      @store.save!
    else
      raise NotFollowing
    end

    respond_to do |format|
      format.html { redirect_to(store_path(@store)) }
      format.json { render :inline => "{'id': '#{@store.id}', 'followed':'false'}", :layout => false }
    end
  end

  # POST /follows
  def create
    authorize! :create, :follows
    @store = Store.find params[:store_id]
    unless @store.following_users.include? current_user
      @store.following_users << current_user
      @store.save!
    else
      raise AlreadyFollowing
    end
    redirect_to store_path(@store)
  end

  # GET /stores/:store_id/follows/new
  def new
    authorize! :create, :follows
    store_id = params[:store_id].to_i
    @store = Store.find store_id

    unless @store.following_users.include? current_user
      @store.following_users << current_user
      @store.save!
    else
      raise AlreadyFollowing
    end

    respond_to do |format|
      format.html {redirect_to store_path(@store) }
      format.json
    end
  end
end

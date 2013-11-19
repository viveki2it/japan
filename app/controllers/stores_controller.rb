# -*- encoding : utf-8 -*-
class StoresController < ApplicationController
  respond_to :json, only: [:index, :show, :update]

  # GET /stores.json
  # GET /categories/1/stores.json
  def index
    @stores = []
    unless params[:category_id].nil?
      @category = Category.find(params[:category_id])
      @stores = @category.stores.order("created_at DESC").page(params[:page])
    else
      @stores = Store.order("created_at DESC").page(params[:page])
    end
  end

  # GET /stores/1.json
  def show
    return if params[:id].blank? ||  params[:id] == "null"
    @store = Store.default_find(params[:id])
    #@store.build_address unless @store.address

    @products = @store.products#.limit 5
    @deals = @store.deals#.limit 5
    @news = @store.news#.limit 4
    redirect_to root_path unless publicly_visible?(@store)
  end

  # PUT /stores/1.json
  def update
    @store = Store.find params[:id]
    authorize! :update, @store

    #params[:store][:logo] = Store.logo_from_base64 params[:logo_base64] if params[:logo_base64] and params[:logo_base64][:image_base64]
    if params[:pictures]
      pictures ||= Array.new
      params[:pictures].each do |img|
        if img[:image_base64]
          img[:picture] ={:store_id => @store.id}
          pictures << Picture.prepare_params(img)
        end

      end
      params[:store][:pictures_attributes] = pictures
    end
    if @store.update_attributes params[:store]
      if params['X-Requested-With'] and params['X-Requested-With'] == 'IFrame'
        @json = ({:logo => {:url => @store.logo.url(:normal)}}.merge! @store.attributes).to_json
        render 'shared/iframe_json', :formats => 'html', :layout => false
      else
        render 'show'
      end
    else
      if params['X-Requested-With'] and params['X-Requested-With'] == 'IFrame'
        @json = {errors: @store.errors}
        render 'shared/iframe_json', :formats => 'html', :layout => false
      else
        render json: {errors: @store.errors}, status: :unprocessable_entity
      end
    end
  end

  # GET /stores/edit
  def edit

    @store = Store.find params[:id]

    authorize! :update, @store
    @products = @store.products#.limit 5
    @deals = @store.deals#.limit 5
    @news = @store.news#.limit 4
    @edit_store_mode = (current_user.id == @store.user_id)
    if @store.wizard_step > 0
      render :layout => 'store_modal'
    end
  end

  # GET /stores/new
  def new
    @user = User.new(params[:user])
    @user.build_store
    render 'new'
  end

  def create
    #if user_signed_in?
    #  render :json => t("flash.pro.already_signed_in"), :status => :unprocessable_entity
    #  return
    #end

    params[:user][:role] ='store_owner'

    @user = User.new(params[:user])
    if @user.save
      @user.store.default_schedule!
      sign_in @user
      render :json => {:location => edit_store_url(@user.store)}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  def erased
    render 'erased'
  end

end

# -*- encoding : utf-8 -*-
class PicturesController < ApplicationController # GET /stores/:store_id/pictures.json
  def index
    @store = Store.find(params[:store_id])
    authorize! :update, @store
    @pictures = @store.library_pictures.page(params[:page])
  end

  def show
    @picture = Picture.find(params[:id])
    authorize! :show, @picture
  end

  def create
    iframe_mode = params['X-Requested-With'] and params['X-Requested-With'] == 'IFrame'
    @picture = Picture.new Picture.prepare_params params
    authorize! :create, @picture
    @picture.save!
    if iframe_mode
      @json = @picture.to_json
      render 'shared/iframe_json', :formats => 'html', :layout => false
    else
      render 'show'
    end
  end

  def update
    @picture = Picture.find(params[:id])
    authorize! :update, @picture
    iframe_mode = params['X-Requested-With'] and params['X-Requested-With'] == 'IFrame'
    @picture.update_attributes! Picture.prepare_params params
    respond_to do |format|
      format.html { redirect_to @picture }
      if iframe_mode
        @json = @picture.to_json
        format.json { render 'shared/iframe_json', :formats => 'html', :layout => false }
      else
        format.json { render 'show' }
      end
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    authorize! :destroy, @picture
    @picture.destroy
  end
end

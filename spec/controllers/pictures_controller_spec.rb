# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PicturesController do
  before do
    @store = create :store
    @user = @store.user
    sign_in @user
  end

  describe ':index action' do
    before do
      15.times do
        decorated = create :news, store: @store
        create :picture, decorated: decorated, store: @store
      end
      @operation = lambda { get 'index', store_id: @store.id }
    end

    before { @operation.call }

    it "should assign @store variable" do
      assigns(:store).should == @store
    end

    it "should assign @pictures variable with store pictures" do
      assigns(:pictures).each { |picture| picture.store_id.should == @store.id }
    end

    describe "pagination" do
      it "should limit pictures count to 10 per page" do
        assigns(:pictures).count.should == 10
      end
      it "should take params[:page] into account" do
        get 'index', store_id: @store.id, page: 2
        assigns(:pictures).count.should < 10
      end
    end

    describe "error handling" do
      before { bypass_rescue }

      it "should raise error when accessed by user w/out permissions" do
        @new_store = create :store
        lambda { get 'index', store_id: @new_store.id }.should raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe ':show method' do
    before do
      @store = create :store
      sign_in @store.user
      decorated = create :news, store: @store
      @picture = create :picture, decorated: decorated, store: @store
    end

    before { get 'show', id: @picture.id, store_id: @store.id }

    it "should assign @picture" do
      assigns(:picture).should == @picture
    end
  end

  describe ':create method', pending: 'needs tests'
  describe ':update method', pending: 'needs tests'
  describe ':destroy method', pending: 'needs tests'
end

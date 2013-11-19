# -*- encoding : utf-8 -*-
require 'spec_helper'

describe FollowsController do
  describe :create do
    before :each do
      @store = create :store
      @user = create :user
      sign_in @user
    end

    subject { post :create, {format: 'json', store_id: @store.id.to_s, user_id: @user.id.to_s} }

    it "should add store to user's followed stores" do
      subject
      User.joins(:followed_stores).find(@user.id).followed_stores.should include(@store)
    end

    it "should add user to store's following users" do
      subject
      Store.joins(:following_users).find(@store.id).following_users.should include(@user)
    end

    it "should redirect_to :index" do
      subject
      response.should redirect_to(store_path @store)
    end

    context "when user is store owner" do
      before :each do
        @user = create :store_owner
        sign_in @user
      end

      it "should forbid access" do
        bypass_rescue
        lambda { subject }.should raise_error(CanCan::AccessDenied)
      end
    end

    context "when user is already following the store" do
      before :each do
        @user = create :user
        @store.following_users << @user
        @store.save
        sign_in @user
      end
      it "should raise error" do
        bypass_rescue
        lambda { subject }.should raise_error(NextdoorzErrors::AlreadyFollowing)
      end
      it "shouldn't change followers number" do
        lambda { subject }.should_not change(@store.following_users, :count)
      end
    end
  end

  describe ":new" do
    before :each do
      @store = create :store
      @user = create :user
      sign_in @user
    end
    subject { get 'new', store_id: @store.id }
    it "should render proper template" do
      subject
      response.should render_template('new')
    end
    it "should assign @store variable" do
      subject
      assigns(:store).should == @store
    end
  end
end

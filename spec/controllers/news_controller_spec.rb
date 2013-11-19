# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cancan/matchers'

describe NewsController do
  before do
    bypass_rescue
  end

  describe ":index method" do
    before do
      50.times { create :news }
      @store = create :store
      20.times { create :news, store: @store }
      @news = create :news
    end

    before { get 'index', {format: 'json'} }

    it { response.should be_success }
    it { assigns(:news).count.should == News.default_per_page }

    context "filtering" do
      before { get 'index', {store_id: @store.id, format: 'json'} }
      it { assigns(:news).should_not include(@news) }
      it { assigns(:store).should == @store }
    end

    context "pagination" do
      before { get 'index', {page: 2, format: 'json'} }
      it { assigns(:news).should_not include(@news) }
    end
  end

  describe ":show method" do
    before do
      @news = create :news
    end

    before { get 'show', {format: 'json', id: @news.id} }

    it { assigns(:news).should == @news }
    it "raises error when id is incorrect" do
      lambda { get 'show', {format: 'json', id: 80085} }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ":create method" do
    before do
      @store = create :store
      sign_in @store.user
      @data = {}
      attributes_for(:news, store_id: @store.id).each { |k, v| @data[k.to_s] = v.to_s }
      @news = News.new(@data)
      @operation = lambda { post 'create', {format: 'json', news: @data} }
    end

    subject { @operation }
    it { should change(News, :count).by(1) }
    it "should use proper params for News creation" do
      News.should_receive(:new).with(@data).and_return(@news)
      @operation.call
    end

    it "should render :show template" do
      @operation.call
      response.should render_template('show')
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end
      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when news is invalid" do
      before do
        @data[:store_id] = nil
      end

      it { should raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe ":update method" do
    before do
      @store = create :store
      sign_in @store.user
      @news = create :news, store: @store
      @updated_attributes = {title: "new name"}.stringify_keys!
      @operation = lambda { put 'update', {format: 'json', id: @news.id, news: @updated_attributes} }
    end

    subject { @operation }

    it { should_not change(News, :count) }
    it { should_not raise_error }
    it "should update attributes of correct news" do
      News.should_receive(:find).with(@news.id.to_s).and_return(@news)
      @news.should_receive(:update_attributes!).with(@updated_attributes)
      @operation.call
    end

    it "should render 'show' template" do
      @operation.call
      response.should render_template('show')
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end

      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when news doesn't exist'" do
      before do
        @operation = lambda { put 'update', {format: 'json', id: 80085, news: @updated_attributes} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe ":destroy method" do
    before do
      @store = create :store
      sign_in @store.user

      @operation = lambda { delete 'destroy', {format: 'json', id: @news.id} }
    end

    before :each do
      @news = create :news, store: @store
    end

    subject { @operation }

    it { should change(News, :count).by(-1) }

    it "should redirect to news list" do
      @operation.call
      response.should redirect_to(news_path)
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end

      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when news doesn't exist'" do
      before do
        @operation = lambda { delete 'destroy', {format: 'json', id: 80085} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

end

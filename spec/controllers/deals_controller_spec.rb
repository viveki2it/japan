# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cancan/matchers'

describe DealsController do
  before do
    bypass_rescue
  end

  describe ":index method" do
    before do
      50.times { create :deal }
      @store = create :store
      20.times { create :deal, store: @store }
      @deal = create :deal
    end

    before { get 'index', {format: 'json'} }

    it { response.should be_success }
    it { assigns(:deals).count.should == Deal.default_per_page }

    context "filtering" do
      before { get 'index', {store_id: @store.id, format: 'json'} }
      it { assigns(:deals).should_not include(@deal) }
      it { assigns(:store).should == @store }
    end

    context "pagination" do
      before { get 'index', {page: 2, format: 'json'} }
      it { assigns(:deals).should_not include(@deal) }
    end
  end

  describe ":show method" do
    before do
      @deal = create :deal
    end

    before { get 'show', {format: 'json', id: @deal.id} }

    it { assigns(:deal).should == @deal }
    it "raises error when id is incorrect" do
      lambda { get 'show', {format: 'json', id: 80085} }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ":create method" do
    before do
      @store = create :store
      sign_in @store.user
      @data = {}
      attributes_for(:deal, store_id: @store.id).each { |k, v| @data[k.to_s] = v.to_s }
      @deal = Deal.new(@data)
      @operation = lambda { post 'create', {format: 'json', deal: @data} }
    end

    subject { @operation }
    it { should change(Deal, :count).by(1) }
    it "should use proper params for Deal creation" do
      Deal.should_receive(:new).with(@data).and_return(@deal)
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

    context "when deal is invalid" do
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
      @deal = create :deal, store: @store
      @updated_attributes = {name: "new name"}.stringify_keys!
      @operation = lambda { put 'update', {format: 'json', id: @deal.id, deal: @updated_attributes} }
    end

    subject { @operation }

    it { should_not change(Deal, :count) }
    it { should_not raise_error }
    it "should update attributes of correct deal" do
      Deal.should_receive(:find).with(@deal.id.to_s).and_return(@deal)
      @deal.should_receive(:update_attributes!).with(@updated_attributes)
      @operation.call
    end

    it "should render 'show' action on success" do
      @operation.call
      response.should render_template('show')
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end

      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when deal doesn't exist'" do
      before do
        @operation = lambda { put 'update', {format: 'json', id: 80085, deal: @updated_attributes} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe ":destroy method" do
    before do
      @store = create :store
      sign_in @store.user

      @operation = lambda { delete 'destroy', {format: 'json', id: @deal.id} }
    end

    before :each do
      @deal = create :deal, store: @store
    end

    subject { @operation }

    it { should change(Deal, :count).by(-1) }

    it "should redirect to deals list" do
      @operation.call
      response.should redirect_to(deals_path)
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end

      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when deal doesn't exist'" do
      before do
        @operation = lambda { delete 'destroy', {format: 'json', id: 80085} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

end

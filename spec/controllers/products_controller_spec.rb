# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cancan/matchers'

describe ProductsController do
  before do
    bypass_rescue
  end

  describe ":index method" do
    before do
      50.times { create :product }
      @store = create :store
      20.times { create :product, store: @store }
      @product = create :product
    end

    before { get 'index', {format: 'json'} }

    it { response.should be_success }
    it { assigns(:products).count.should == Product.default_per_page }

    context "filtering" do
      before { get 'index', {store_id: @store.id, format: 'json'} }
      it { assigns(:products).should_not include(@product) }
      it { assigns(:store).should == @store }
    end

    context "pagination" do
      before { get 'index', {page: 2, format: 'json'} }
      it { assigns(:products).should_not include(@product) }
    end
  end

  describe ":show method" do
    before do
      @product = create :product
    end

    before { get 'show', {format: 'json', id: @product.id} }

    it { assigns(:product).should == @product }
    it "raises error when id is incorrect" do
      lambda { get 'show', {format: 'json', id: 80085} }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ":create method" do
    before do
      @store = create :store
      sign_in @store.user
      @data = {}
      attributes_for(:product, store_id: @store.id).each { |k, v| @data[k.to_s] = v.to_s }
      @product = Product.new(@data)
      @operation = lambda { post 'create', {format: 'json', product: @data} }
    end

    subject { @operation }
    it { should change(Product, :count).by(1) }
    it "should use proper params for Product creation" do
      Product.should_receive(:new).with(@data).and_return(@product)
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

    context "when product is invalid" do
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
      @product = create :product, store: @store
      @updated_attributes = {name: "new name"}.stringify_keys!
      @operation = lambda { put 'update', {format: 'json', id: @product.id, product: @updated_attributes} }
    end

    subject { @operation }

    it { should_not change(Product, :count) }
    it { should_not raise_error }
    it "should update attributes of correct product" do
      Product.should_receive(:find).with(@product.id.to_s).and_return(@product)
      @product.should_receive(:update_attributes!).with(@updated_attributes)
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

    context "when product doesn't exist'" do
      before do
        @operation = lambda { put 'update', {format: 'json', id: 80085, product: @updated_attributes} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe ":destroy method" do
    before do
      @store = create :store
      sign_in @store.user

      @operation = lambda { delete 'destroy', {format: 'json', id: @product.id} }
    end

    before :each do
      @product = create :product, store: @store
    end

    subject { @operation }

    it { should change(Product, :count).by(-1) }

    it "should redirect to products list" do
      @operation.call
      response.should redirect_to(products_path)
    end

    context "when wrong user is signed in" do
      before do
        sign_in create(:user)
      end

      it { should raise_error(CanCan::AccessDenied) }
    end

    context "when product doesn't exist'" do
      before do
        @operation = lambda { delete 'destroy', {format: 'json', id: 80085} }
      end
      subject { @operation }

      it { should raise_error(ActiveRecord::RecordNotFound) }
    end
  end

end

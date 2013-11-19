# -*- encoding : utf-8 -*-
require 'spec_helper'

describe StoresController do
  before do
    bypass_rescue
  end
  describe ":index action" do
    before do
      50.times { create :store }
      @category = create :category
      @store_one = create :store, category: @category
      @store_two = create :store, category: @category
    end

    it "should assign 25 newest stores" do
      get 'index', format: 'json'
      assigns(:stores).should include(@store_one)
      assigns(:stores).count.should == Store.default_per_page
    end

    it "should paginate" do
      get 'index', format: 'json', page: 2
      assigns(:stores).should_not include(@store_one)
    end

    it "should allow filtering by category" do
      get 'index', format: 'json', category_id: @category.id
      assigns(:stores).should == [@store_two, @store_one]
      assigns(:category).should == @category
    end
  end

  describe ":show action" do
    before do
      @store = create :store
    end

    it "should assign store" do
      get 'show', format: 'json', id: @store.id
      assigns(:store).should == @store
    end
  end
  describe ":update action" do
    before :each do
      @store = create :store
      sign_in @store.user
    end

    before do
      @updated_attributes = {'name' => 'new_name'}
    end


    subject { lambda { put 'update', format: 'json', id: @store.id, store: @updated_attributes } }

    it "should update attributes" do
      Store.should_receive(:find).with(@store.id.to_s).and_return @store
      @store.should_receive(:update_attributes!).with(@updated_attributes)
      subject.call
    end

    it "should raise error when user is not owner of the store" do
      @store = create :store
      subject.should raise_error(CanCan::AccessDenied)
    end

    it "should not allow ownership change" do
      @correct_attributes = @updated_attributes.clone
      @updated_attributes['user_id'] = 80085
      Store.should_receive(:find).with(@store.id.to_s).and_return @store
      @store.should_receive(:update_attributes!).with(@correct_attributes)
      subject.call
    end

    it "should render 'show' template" do
      subject.call
      response.should render_template('show')
    end
  end
end

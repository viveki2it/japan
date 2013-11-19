# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cancan/matchers'

describe CategoriesController do
  before do
    bypass_rescue
  end

  describe ":index method" do
    before do
      10.times { create :category }
      @category = create :category
    end

    before { get 'index', {format: 'json'} }

    it { response.should be_success }
    it { assigns(:categories).count.should == 11 }
    it { assigns(:categories).should include(@category) }
  end
end

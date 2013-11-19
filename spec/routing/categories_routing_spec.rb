# -*- encoding : utf-8 -*-
require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "routes to list of stores" do
      get("/categories/1/stores").should route_to("stores#index", category_id: '1')
    end

    it "routes to #index" do
      get("/categories").should route_to("categories#index")
    end
  end
end

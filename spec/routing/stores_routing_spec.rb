# -*- encoding : utf-8 -*-
require "spec_helper"

describe StoresController do
  describe "routing" do

    describe "member" do
      it "routes to deals" do
        get("/stores/1/deals").should route_to("deals#index", store_id: '1')
      end
      it "routes to news" do
        get("/stores/1/news").should route_to("news#index", store_id: '1')
      end
      it "routes to products" do
        get("/stores/1/products").should route_to("products#index", store_id: '1')
      end
    end

    it "routes to #index" do
      get("/stores").should route_to("stores#index")
    end

    it "doesnt route to #new" do
      get("/stores/new").should_not route_to("stores#new")
    end

    it "routes to #show" do
      get("/stores/1").should route_to("stores#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/stores/1/edit").should_not route_to("stores#edit", :id => "1")
    end

    it "doesn't route to #create" do
      post("/stores").should_not route_to("stores#create")
    end

    it "routes to #update" do
      put("/stores/1").should route_to("stores#update", :id => "1")
    end

    it "doesn't route to #destroy" do
      delete("/stores/1").should_not route_to("stores#destroy", :id => "1")
    end

    it "routes to follows#index" do
      get("/stores/1/follows").should route_to("follows#index", store_id: '1')
    end
  end
end

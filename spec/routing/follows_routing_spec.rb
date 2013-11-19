# -*- encoding : utf-8 -*-
require 'spec_helper'

describe FollowsController do
  describe "routing" do
    it "should route to followed news" do
      get("/follows/news").should route_to("news#index", followed: true)
    end
    it "should route to followed products" do
      get("/follows/products").should route_to("products#index", followed: true)
    end
    it "should route to followed deals" do
      get("/follows/deals").should route_to("deals#index", followed: true)
    end
    it "should route to create" do
      post("/follows").should route_to("follows#create")
    end
    it "should route to destroy" do
      delete("/stores/123/follows/").should route_to("follows#destroy", store_id: '123')
    end
    it "should route_to index" do
      get("/follows").should route_to("follows#index")
    end

    it "routes to follows#new" do
      get("stores/1/follows/new").should route_to("follows#new", store_id: "1")
    end
  end
end

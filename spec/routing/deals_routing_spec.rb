# -*- encoding : utf-8 -*-
require "spec_helper"

describe DealsController do
  describe "routing" do

    it "routes to #index" do
      get("/deals").should route_to("deals#index")
    end

    it "doesnt route to #new" do
      get("/deals/new").should_not route_to("deals#new")
    end

    it "routes to #show" do
      get("/deals/1").should route_to("deals#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/deals/1/edit").should_not route_to("deals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deals").should route_to("deals#create")
    end

    it "routes to #update" do
      put("/deals/1").should route_to("deals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deals/1").should route_to("deals#destroy", :id => "1")
    end

  end
end

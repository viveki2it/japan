# -*- encoding : utf-8 -*-
require "spec_helper"

describe PicturesController do
  describe 'routing' do
    it "should route to /stores/:store_id/pictures" do
      get('/stores/123/pictures').should route_to('pictures#index', store_id: '123')
    end
    it "should route to single picture" do
      get('/stores/123/pictures/1').should route_to('pictures#show', store_id: '123', id: '1')
    end
    it "should route to picture creation" do
      post('/stores/123/pictures').should route_to('pictures#create', store_id: '123')
    end
    it "should route to picture update" do
      put('/stores/123/pictures/1').should route_to('pictures#update', store_id: '123', id: '1')
    end
    it "should route to picture destruction" do
      delete('/stores/123/pictures/1').should route_to('pictures#destroy', store_id: '123', id: '1')
    end
    it "should route to single picture directly" do
      get('/pictures/1').should route_to('pictures#show', id: '1')
    end
  end
end

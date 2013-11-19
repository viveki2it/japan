# -*- encoding : utf-8 -*-
require "spec_helper"
require "cancan/matchers"

describe Ability do
  let(:ability) { Ability.new @user }
  subject { ability }
  context "Administrator" do
    before do
      @user = create :user, role: 'admin'
    end

    it { should be_able_to :manage, :all }
    it { should be_able_to :access, :rails_admin }
  end

  context "Store owner" do
    before do
      @user = create :store_owner
    end

    it { should be_able_to :manage, Store, user_id: @user.id }
    it { should be_able_to :manage, Deal, store_id: @user.store.id }
    it { should be_able_to :manage, News, store_id: @user.store.id }
    it { should be_able_to :manage, Product, store_id: @user.store.id }
    it { should be_able_to :manage, Picture, store_id: @user.store.id }
  end

  context "Normal user" do
    before do
      @user = create :user
    end

    it { should be_able_to(:create, :follows) }
    it { should be_able_to(:destroy, :follows) }
  end

  context "Guest" do
    before do
      @user = create :user, role: 'guest'
    end

    it { should be_able_to :manage, @user }
    it { should be_able_to :show, Store }
    it { should be_able_to :show, Deal }
    it { should be_able_to :show, News }
    it { should be_able_to :show, Product }
    it { should be_able_to :index, Store }
    it { should be_able_to :index, Deal }
    it { should be_able_to :index, News }
    it { should be_able_to :index, Product }
    it { should be_able_to :index, Category }
    it { should be_able_to :show, Category }
    it { should be_able_to :show, Picture }
  end
end

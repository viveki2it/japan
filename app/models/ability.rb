# -*- encoding : utf-8 -*-
# Abilities are described in wiki: https://jellybeans.plan.io/projects/nextdoorz/wiki/Access_control
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, user
    can [:index, :show], [Store, Deal, News, Product, Variant]
    can [:index, :show], Category
    can :show, Picture

    if user.admin?
      can :manage, :all
      can :access, :rails_admin
    end

    if user.user?
      can [:show, :create, :destroy], :follows
      can :manage, Board, user_id: user.id
      can [:add_to_wishlist, :remove_from_wishlist], Product
      can [:add_to_wishlist, :remove_from_wishlist], Deal
    end

    if user.store_owner?
      can :manage, Store, user_id: user.id
      can :manage, [Deal, News, Product, Picture], store_id: user.store.id
      can :manage, Variant, store: {store_id: user.store.id}
    end
  end
end

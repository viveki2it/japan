class AddSiteAndFacebookUrlsToStores < ActiveRecord::Migration
  def change
    add_column :stores, :website_url, :string
    add_column :stores, :facebook_url, :string
  end
end

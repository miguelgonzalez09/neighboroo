class AddAmazonLinksToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :amazon, :string

  end
end

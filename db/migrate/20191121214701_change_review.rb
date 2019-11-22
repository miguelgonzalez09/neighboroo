class ChangeReview < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :rating, :integer
  end
end

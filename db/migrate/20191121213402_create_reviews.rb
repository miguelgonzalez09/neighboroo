class CreateReviews < ActiveRecord::Migration[5.2]
  belongs_to :user
  def change
    create_table :reviews do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end

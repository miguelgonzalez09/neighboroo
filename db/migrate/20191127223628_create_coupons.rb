class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.datetime :date
      t.string :amazon
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :status

      t.timestamps
    end
  end
end

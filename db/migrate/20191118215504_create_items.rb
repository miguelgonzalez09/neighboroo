class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :photo
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

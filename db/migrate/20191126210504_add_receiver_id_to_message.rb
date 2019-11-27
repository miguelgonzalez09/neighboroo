class AddReceiverIdToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :receiver_id, :integer
  end
end

class AddRecipientToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :recipient, :integer
  end
end

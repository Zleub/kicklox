class ChangeRecipientReferenceFromMessages3 < ActiveRecord::Migration[5.2]
  def change
    change_table :messages do |t|
      t.remove :recipient
      t.references :recipient, foreign_key: { to_table: :users}
    end  
  end
end

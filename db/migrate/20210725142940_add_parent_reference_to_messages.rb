class AddParentReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    change_table :messages do |t|
      t.references :parent, foreign_key: { to_table: :messages}
    end  
  end
end

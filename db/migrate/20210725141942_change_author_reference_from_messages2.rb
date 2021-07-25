class ChangeAuthorReferenceFromMessages2 < ActiveRecord::Migration[5.2]
  def change
    change_table :messages do |t|
      t.remove :author
      t.references :author, foreign_key: { to_table: :users}
    end  
  end
end

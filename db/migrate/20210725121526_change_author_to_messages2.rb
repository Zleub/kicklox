class ChangeAuthorToMessages2 < ActiveRecord::Migration[5.2]
  def change
    change_table :messages do |t|
      t.belongs_to :user, index: true
    end  
  end
end

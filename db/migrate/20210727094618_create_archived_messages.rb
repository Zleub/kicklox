class CreateArchivedMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :archived_messages do |t|
      t.text :body
      t.boolean :public
      t.references :author, foreign_key: { to_table: :users}
      t.references :recipient, foreign_key: { to_table: :users}
      t.references :parent, foreign_key: { to_table: :archived_messages}

      t.timestamps
    end
  end
end

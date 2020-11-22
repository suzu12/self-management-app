class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.string :content, null: false
      t.timestamps
    end
  end
end

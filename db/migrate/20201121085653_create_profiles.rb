class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.text :bio,        null: false
      t.date :birthday,   null: false
      t.integer :gender,  null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

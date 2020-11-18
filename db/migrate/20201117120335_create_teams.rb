class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :category_id,  null: false
      t.string  :team_name,    null: false
      t.text    :introduction, null: false
      t.integer :period_id,    null: false
      t.timestamps
    end
  end
end

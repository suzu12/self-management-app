class CreateTeamUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_users do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.timestamps
    end
  end
end

class CreateTeamTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :team_tag_relations do |t|
      t.references :team, foreign_key: true
      t.references :tag,  foreign_key: true
      t.timestamps
    end
  end
end

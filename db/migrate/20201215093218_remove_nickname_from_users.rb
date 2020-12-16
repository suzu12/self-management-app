class RemoveNicknameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :nickname, :string
  end
end

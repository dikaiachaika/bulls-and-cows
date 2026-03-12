# db/migrate/20260312140000_remove_user_id_from_games.rb
class RemoveUserIdFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :user_id, :integer
  end
end
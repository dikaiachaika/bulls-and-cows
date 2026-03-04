class AddFieldsToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :digit_length, :integer
    add_column :games, :started_at, :datetime
    add_column :games, :completed_at, :datetime
  end
end

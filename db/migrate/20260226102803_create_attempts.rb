class CreateAttempts < ActiveRecord::Migration[8.1]
  def change
    create_table :attempts do |t|
      t.references :game, null: false, foreign_key: true
      t.string :guess
      t.integer :bulls
      t.integer :cows

      t.timestamps
    end
  end
end

class AddSecurityQuestionToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :security_question, :string
    add_column :users, :security_answer, :string
  end
end

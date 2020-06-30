class ChangeUserColumm < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :content, :string
    add_column :users, :answer_point, :integer, default:0
  end
end

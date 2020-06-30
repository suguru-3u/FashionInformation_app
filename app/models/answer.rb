class Answer < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :comment

  # good_answerしているのかのチェックメゾット
  def answers_user(user_id, comment_id)
    Answer.where(user_id: user_id, comment_id: comment_id).exists?
  end
end

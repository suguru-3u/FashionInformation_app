namespace :user_count do
  desc "ユーザーのanswer_pointカラムを0にする"
  task user_answer_point_reset: :environment do
    users = User.where("answer_point > ?", 0)
    users.each do |users|
      users.update(answer_point: 0)
    end
  end
end

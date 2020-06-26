class NotificationMailer < ApplicationMailer
  default from: 'fashioninformation <noreply@my-domain.com>', charset: 'ISO-2022-JP'

  def complete_mail(user)
    @user = user
    @url = "http://localhost:3000"
    mail(subject: "コメントを頂きました" ,to: @user.email)
  end

  def user_update(user)
    @url = "http://localhost:3000"
    @user = user
    mail(subject: "登録情報の変更" ,to: @user.email)
  end

  def user_contact
      @url = "http://localhost:3000"
      mail(subject: "お問い合わせがありました" ,to: ENV['Gmail_name'])
  end


  def user_count
    @today_user_count = User.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    @user_count = User.count
    mail(subject: "ユーザー数の報告" ,to: ENV['Gmail_name'])
  end


  def user_answer_point_count_rank
    users = User.where("answer_point > ?", 0)
    users.each do |user|
      @user_email = user.email
    end
    mail(subject: "Good コメントランキングの報告" ,to: @user_email)
  end

end

class NotificationMailer < ApplicationMailer
  default from: 'fashioninformation <noreply@my-domain.com>', charset: 'ISO-2022-JP'

  def complete_mail(user)
    @user = user
    @url = "https://fashioninformation.net"
    mail(subject: "コメントを頂きました", to: @user.email)
  end

  def user_update(user)
    @url = "https://fashioninformation.net"
    @user = user
    mail(subject: "登録情報の変更", to: @user.email)
  end

  def user_contact
    @url = "https://fashioninformation.net/admins/sign_in"
    mail(subject: "お問い合わせがありました", to: ENV['Gmail_name'])
  end

  def user_count
    @today_user_count = User.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    @user_count = User.count
    mail(subject: "ユーザー数の報告", to: ENV['Gmail_name'])
  end
end

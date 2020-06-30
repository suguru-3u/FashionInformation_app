# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:

# 絶対パスから相対パス指定
env :PATH, ENV['PATH']

# ログファイルの出力先
set :output, 'log/cron.log'

# ジョブの実行環境の指定
rails_env = ENV['RAILS_ENV'] || :production

set :environment, rails_env

#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 3時間毎に実行するスケジューリング
every 1.days, pm: '15:00 am' do
  runner "NotificationMailer.user_count.deliver_now"
end

every :monday, at: ['12:00 pm'] do
  rake "user_count:user_answer_point_reset"
end

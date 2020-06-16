class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com', charset: 'ISO-2022-JP'
  layout 'mailer'
end

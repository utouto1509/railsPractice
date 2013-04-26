# -*- encoding: utf-8 -*-

class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(user)
    @greeting = "Hi"
    @user = user

    mail to: "to@example.org"
    subject: "test mail"
  end

  def send_mail
     user = User.find(1)
     @mail = NoticeMailer.sendmail_(user).deliver
     render :text => "送信できた!"
  end
end

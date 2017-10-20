class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_fb.subject
  #
  def sendmail_fb(topic)
    @greeting = "こんにちは"
    @topic = topic

    mail to: "ksk55jp@gmail.com",
      subject: "[FriendsBook] 投稿されました。投稿者：#{@topic.user.name} タイトル：#{@topic.title}"
  end
end

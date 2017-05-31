class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_question.subject
  #
  def sendmail_question(question)
    @question = question
    mail to: question.user.email,
         subject: "【Stack Overflow】#{@question.title}"
  end
end

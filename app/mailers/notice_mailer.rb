class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_question.subject
  #
  def sendmail_question(question)
    @question = question
    mail to: question.user.email,
         subject: "【Stack Overflow】#{question.title}"
  end

  def sendmail_answer(answer)
    @answer = answer
    #回答した場合、質問者にメールで送信
    mail to: answer.question.user.email,
         subject: "【Stack Overflow】#{answer.question.title}"
  end
end

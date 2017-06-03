class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @question = @answer.question
    respond_to do |format|
      if @answer.save
        flash[:notice] = '回答を投稿しました'
        format.html { redirect_to question_path(@question) }
        format.js { render js: "window.location = '#{question_path(@question)}'" }
        NoticeMailer.sendmail_answer(@answer).deliver
      else
        format.js { render :error }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def answer_params
    params.require(:answer).permit(:question_id, :content)
  end
end

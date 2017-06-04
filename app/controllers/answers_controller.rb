class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:edit, :update, :destroy]

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
    respond_to do |format|
      if @answer.update(answer_params)
        format.js { render js: "window.location = '#{question_path(@question)}'" }
      else
        render 'edit'
      end
    end
  end

  def destroy
    if @answer.destroy
      redirect_to question_path(@question), notice: '回答を削除しました'
    else
      redirect_to question_path(@question), notice: '回答を削除できませんでした'
    end
  end

  def show
  end

  private
    def answer_params
      params.require(:answer).permit(:question_id, :content)
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      @question = @answer.question
    end
end

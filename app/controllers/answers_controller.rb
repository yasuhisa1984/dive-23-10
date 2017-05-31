class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @question = @answer.question
    if @answer.save
      redirect_to question_path(@question), notice: '回答を投稿しました'
    else
      redirect_to question_path(@question)
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

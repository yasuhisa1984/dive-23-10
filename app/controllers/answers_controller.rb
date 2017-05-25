class AnswersController < ApplicationController
  def index
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @question = @answer.question
    @answer.save
    redirect_to question_path(@question)
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

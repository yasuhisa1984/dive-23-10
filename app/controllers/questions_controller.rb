class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.save
    redirect_to questions_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private
    def question_params
      params.require(:question).permit(:title, :content)
    end
end

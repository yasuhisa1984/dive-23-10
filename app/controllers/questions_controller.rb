class QuestionsController < ApplicationController

  before_action :set_question, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.save
    redirect_to questions_path
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path, notice: '質問を更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: '質問を削除しました'
    else
      render 'edit'
    end
  end

  def show
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end
    def question_params
      params.require(:question).permit(:title, :content)
    end
end

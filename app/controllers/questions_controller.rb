class QuestionsController < ApplicationController

  before_action :set_question, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.order(created_at: :desc).includes(:user, :tags)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    input_tags_names.each do |name|
      tag = Tag.register!(name)
      @question.taggings.build(tag_id: tag.id)
    end
    if @question.save
      redirect_to questions_path, notice:"質問を投稿しました"
      NoticeMailer.sendmail_question(@question).deliver
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @question.tags.destroy_all
    input_tags_names.each do |name|
      tag = Tag.register!(name)
      @question.taggings.build(tag_id: tag.id)
    end
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
    @answer = @question.answers.build
    @answers = @question.answers
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end
    def question_params
      params.require(:question).permit(:title, :content)
    end
    def input_tags_names
      params.require(:question).permit(:tags)['tags'].split(",")
    end
end

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    favorite = current_user.favorites.build(question_id: @question.id)
    unless favorite.save
      redirect_to user_path(@question.id)
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    @question = favorite.question
    unless favorite.destroy
      redirect_to user_path(@question.id)
    end
  end
end

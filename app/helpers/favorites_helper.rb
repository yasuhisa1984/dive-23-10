module FavoritesHelper
  def is_favorite?(question)
    Favorite.find_by(user_id: current_user.id, question_id: question.id) != nil
  end
end

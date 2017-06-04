class RankingController < ApplicationController
  def index
    @questions = Question.favorite_ranking(10).includes(:user, :tags)
  end
end

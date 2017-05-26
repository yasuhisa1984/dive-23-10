class RankingController < ApplicationController
  def index
    @questions = Question.favorite_ranking(10)
  end
end

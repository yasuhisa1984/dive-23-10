class VotesController < ApplicationController
  def create
    @question = params[:question_id]
    if current_user.question_voting_plus_or_minus_or_nil(@question)
      @vote = Vote.find(params[:id])
      @vote.destroy
      redirect_to question_path(@question)
    else
      @question = Question.find(params[:question_id])
      if params[:is_up] == "true"
        plus_or_minus = 1
      else
        plus_or_minus = -1
      end
      Vote.create(user_id: current_user.id, question_id: @question.id, plus_or_minus: plus_or_minus)
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = params[:question_id]
    if current_user.question_voting_plus_or_minus_or_nil(@question)
      @vote = Vote.find(params[:id])
      @vote.destroy
      redirect_to question_path(@question)
    else
      @question = Question.find(params[:question_id])
      plus_or_minus = -1
      Vote.create(user_id: current_user.id, question_id: @question.id, plus_or_minus: plus_or_minus)
      redirect_to question_path(@question)
    end
  end
end
